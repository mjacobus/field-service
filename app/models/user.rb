class User < ApplicationRecord
  class ValidationError < RuntimeError
    attr_reader :user
    def initialize(user)
      super('Invalid user')
      @user = user
    end
  end

  include Clearance::User

  def territories
    if admin?
      return Territory.all
    end

    publisher_ids = UserPublisher.where(user_id: id).select(:publisher_id)
    Territory.where(responsible_id: publisher_ids)
  end

  # TODO: quick code. Need to be extracted into a descent service
  def self.update_profile(user, attributes)
    password = attributes[:password].presence
    new_password = attributes[:new_password].presence
    user.email = attributes[:email]

    unless user.valid?
      raise ValidationError, user
    end

    if new_password
      unless user.authenticated?(password)
        user.errors.add(:password, :invalid)
      end

      user.password = new_password
    end

    unless user.errors.empty?
      raise ValidationError, user
    end

    user.save!
  end
end
