class ProfilesController < AuthenticatedController
  skip_before_action :require_admin

  def edit
    @user = current_user
  end

  def update
    User.update_profile(current_user, user_params)
    redirect_to territories_path
  rescue User::ValidationError => error
    @user = error.user
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:email, :new_password, :password)
  end
end
