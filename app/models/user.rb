class User < ApplicationRecord
  include Clearance::User

  def territories
    if admin?
      return Territory.all
    end

    publisher_ids = UserPublisher.where(user_id: id).select(:publisher_id)
    Territory.where(responsible_id: publisher_ids)
  end
end
