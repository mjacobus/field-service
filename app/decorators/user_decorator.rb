# frozen_string_literal: true

class UserDecorator < ActiveRecordModelDecorator
  def index_url
    '/admin/users'
  end

  def to_s
    return name if id

    t('links.new')
  end

  def admin
    boolean_to_human(item.admin?)
  end
end
