# frozen_string_literal: true

module Admin
  class UsersController < AuthenticatedController
    def index
      @users = User.by_name
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_attributes)
      @user.password = UniqueId.new

      if @user.save
        redirect_to '/admin/users'
        return
      end

      render :new, status: 422
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      data = user_attributes

      if password
        data[:password] = password
      end

      if @user.update(data)
        redirect_to '/admin/users'
        return
      end

      render :edit, status: 422
    end

    def destroy
      user = User.find(params[:id])
      user.destroy

      redirect_to '/admin/users'
    end

    private

    def user_attributes
      params.require(:user).permit(:name, :email, :admin, publisher_ids: []).tap do |attr|
        attr[:publisher_ids] ||= []
      end
    end

    def password
      params[:user][:password].presence
    end
  end
end
