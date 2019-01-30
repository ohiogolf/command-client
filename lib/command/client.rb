require "command/client/base"
require "command/client/version"

require "command/client/address"
require "command/client/club"
require "command/client/phone"
require "command/client/ping"
require "command/client/url"

module Command
  module Client
    @company_name = nil
    @user_name = nil
    @password = nil

    class << self
      attr_accessor :company_name, :user_name, :password
    end
  end
end
