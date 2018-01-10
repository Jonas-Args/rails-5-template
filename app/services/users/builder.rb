module Users
  class Builder
    def initialize params = nil
        @params = params
    end
    def basic_details obj
      ({
        id: obj&.id,
        first_name: obj&.first_name,
        last_name: obj&.last_name,
        email: obj&.email,
        profile_photo: obj&.profile_photo&.url
      })
    end

  end
end
