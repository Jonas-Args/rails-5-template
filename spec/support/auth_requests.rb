#
# Authenticated requests
#
[:get, :patch, :put, :post, :delete].each do |method|

  define_method "auth_#{method}" do |path, *args|
    params = args[0] || {}
    headers = args[1] || {}
    send(method, path, params: params, headers: headers.merge(AccessToken: current_user.current_token))
  end

  define_method "admin_auth_#{method}" do |path, *args|
    params = args[0] || {}
    headers = args[1] || {}
    send(method, path, params: params, headers: headers.merge(AccessToken: current_admin.current_token))
  end

end
