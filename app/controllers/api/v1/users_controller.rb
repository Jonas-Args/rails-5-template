class Api::V1::UsersController < ApiController
  skip_before_action :authenticate_request, only: [:create, :forgot_password, :reset_password]

  def create
    user = User.create(obj_params)
    if user.valid?
      render json: Sessions::Builder.new(user).sign_up_details
    else
      obj_errors user
    end
  end

  def update
    user = current_user
    if user.update_attributes(obj_params)
      render json: Sessions::Builder.new(user).sign_up_details
    else
      obj_errors user
    end
  end


  def forgot_password
    user = User.find_by_email(params[:email].downcase)
    unless user.present?
      fail ApiExceptions::InvalidEmailError
    else
      temp = SecureRandom.base64(6)
      if user.assign_temporary_password temp
        user.send_reset_password_email
        render_success
      else
        render_error('Failed to reset password', 422)
      end
    end
  end

  def reset_password
    user = User.find_by_reset_password_token(params[:token].downcase)
    unless user.present?
      fail ApiExceptions::InvalidTokenError
    else
      if user.reset_password(params[:password]) && user.set_access_token
        render json: Sessions::Builder.new(user).show
      else
        render_error('Failed to reset password', 422)
      end
  end

  end

  private

  def resource_name
    "User"
  end

  def obj_params
    params.require(:user).permit(
      :id,
      :first_name,
      :last_name,
      :email,
      :password)
  end
end
