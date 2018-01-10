def current_user
  return @user if @user.present?
  @user ||= FactoryBot.create(:user, password: "!123OnePassword")
  @user.set_access_token
  @user
end

def current_admin
  return @admin_user if @admin_user.present?
  @admin_user ||= FactoryBot.create(:admin_user, password: "adminPassWord")
  @admin_user.set_access_token
  @admin_user
end
