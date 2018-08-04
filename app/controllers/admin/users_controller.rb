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

      if @user.update(user_attributes)
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
      params.require(:user).permit(:name, :email, :admin)
    end
  end
end
