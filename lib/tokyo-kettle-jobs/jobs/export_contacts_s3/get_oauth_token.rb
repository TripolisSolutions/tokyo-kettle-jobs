action = ARGV[0].to_s.lstrip.rstrip

case action
  when 'get_token'
    token = ApiCommTokenHelper.get_auth_token
    return token
end

