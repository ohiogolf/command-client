require 'faraday'
require 'faraday_middleware'
require 'pry'

module Command
  module Client
    class Base
      @api_operation_name = nil
      class << self
        attr_accessor :api_operation_name
      end

      def self.operation(operation_name)
        @api_operation_name = operation_name
      end

      def self.base_url
        "https://#{Command::Client.company_name}.commandsystem.org/command/?page=api&un=#{Command::Client.user_name}&pw=#{Command::Client.password}"
      end

      def self.connection
        ::Faraday.new(base_url) do |conn|
          conn.response :xml
          conn.adapter ::Faraday.default_adapter
        end
      end

      def self.call(params={})
        query_hash = { operation: api_operation_name }.merge(params)
        query_params = URI.encode_www_form(query_hash)
        response = connection.get("?#{query_params}")
        new(response.body)
      end
      self.singleton_class.send(:alias_method, :find, :call)


      attr_reader :_raw, :success, :message

      def initialize(attrs)
        @_raw = attrs["result"]
        @success = @_raw["success"]
        @message = @_raw["message"]
        build(@_raw)
      end

      def success?
        @success == "true"
      end

      def build(attrs)
        # overwrite in subclass
      end
    end
  end
end
