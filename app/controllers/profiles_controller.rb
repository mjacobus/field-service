class ProfilesController < AuthenticatedController
  skip_before_action :require_admin

  def edit
    @user = current_user
  end

  def update
    password = user_params[:password].presence
    new_password = user_params[:new_password].presence

    user = current_user

    user.email = user_params[:email]
    user.valid?

    if new_password
      unless user.authenticated?(password)
        user.errors.add(:password, :invalid)
      end

      user.password = new_password
    end

    if user.errors.empty?
      user.save!
      redirect_to territories_path
      return
    end

    @user = user
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:email, :new_password, :password)
  end
end
