module Command
  module Client
    module Requestable
      def self.included(base)
        base.extend(ClassMethods)

        #
        # Initializer typically receives a hash of attributes to bet set on the model
        #
        def initialize(*attrs)
        end

        #
        # Allow instance to determine if has intrinsic value.
        #   example:  a Phone without a `number` set would be worthless
        #
        def worthless?
          false
        end
      end

      module ClassMethods
        #
        # Allow class to specify a default api `operation` that is used when calling the remote Command API endpoint
        #
        attr_reader :api_operation_name
        def operation(operation_name)
          @api_operation_name = operation_name
        end

        #
        # Returns an array of instantiated models with attributes properly set.
        #
        def many(attrs, *opts)
          [attrs].compact.flatten.map { |model_attrs|
            new(model_attrs)
          }.reject(&:worthless?)
        end

        #
        # Make a remote Command API request using `operation` and any additional `params`
        #
        def call(params={})
          request = Request.new(operation: api_operation_name, params: params).call
          new(request.result)
        end
        alias_method :find, :call
      end
    end
  end
end