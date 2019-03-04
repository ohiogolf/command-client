module Command
  module Client
    #
    # Error raised when the Command API endpoint reports an error often due to incorrect request parameters
    #
    class ApiRequestError < StandardError
      attr_reader :request

      def initialize(msg="Remote Command API returned error", request=nil)
        @request = request
        super(msg)
      end

      def to_s
        [super, request.inspect].join("\n")
      end
    end
  end
end