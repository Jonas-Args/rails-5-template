module Sessions
  class Builder

    def initialize current_user
      @current_user = current_user
      @current_user.set_access_token
    end

    def show
      {
        id: @current_user.id,
        first_name: @current_user.first_name,
        last_name: @current_user.last_name,
        email: @current_user.email,
        access_token: @current_user.current_token
      }
    end

    def sign_up_details
      basic_details = show
      basic_details.merge(Users::Builder.new.basic_details(@current_user))
    end

  end
end
