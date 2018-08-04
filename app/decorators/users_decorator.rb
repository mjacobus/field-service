class UsersDecorator < ActiveRecordCollectionDecorator
  def index_url
    '/admin/users'
  end

  def item_decorator_class
    UserDecorator
  end


  def title_for(attribute_name)
    UserDecorator.new(User.new).title_for(attribute_name)
  end
end

