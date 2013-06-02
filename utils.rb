require 'cgi'

module Utils
  def self.decode_params_url(str)
    b = CGI::unescape(str)
    params = {}

    a = b.split("&")

    a.each do |var|
      key, value = var.split("=")
      params[key] = value
    end

    return params
  end
end