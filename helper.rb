def client
  OAuth2::Client.new('api_key', 'api_secret', :site => 'https://graph.facebook.com')
end


def redirect_uri
  uri = URI.parse(request.url)
  uri.path = '/auth/facebook/callback'
  uri.query = nil
  uri.to_s
end