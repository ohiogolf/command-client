require 'faraday'
require 'faraday_middleware'
require 'pry'

module Command
  module Client
    class Request
      attr_accessor :operation, :params, :response, :result

      def initialize(operation:, params: {})
        @operation = operation
        @params = params
      end

      def call
        query_hash = { operation: operation }.merge(params)
        query_params = URI.encode_www_form(query_hash)
        @response = connection.get("?#{query_params}")

        if !success?
          raise Command::Client::ApiRequestError.new(message, self)
        end

        self
      end

      def result
        Hash(@response.body["result"])
      end

      def message
        result["message"]
      end

      def row_count
        result["row_count"]&.to_i
      end

      def success?
        result["success"] == "true"
      end

      def sql
        result["sql"]
      end


      private

      def connection
        ::Faraday.new(base_url) do |conn|
          conn.response :xml
          conn.adapter ::Faraday.default_adapter
        end
      end

      def base_url
        "https://#{Command::Client.company_name}.commandsystem.org/command/?page=api&un=#{Command::Client.user_name}&pw=#{Command::Client.password}"
      end
    end
  end
end
