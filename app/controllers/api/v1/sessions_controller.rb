class Api::V1::SessionsController < ApiController
  skip_before_action :authenticate_request, only: :create

  def create
    @user = User.find_by_credentials(params[:user])
    if @user.present? && @user.set_access_token
      render json: Sessions::Builder.new(@user).sign_up_details
    else
      fail InvalidCredentialsError
    end
  end

  def show
    render json: Sessions::Builder.new(current_user).show
  end

  def destroy
    if current_user.destroy_token
      render_success
    else
      fail InvalidRequestError
    end
  end


  private

  def resource_name
    "User"
  end

end
