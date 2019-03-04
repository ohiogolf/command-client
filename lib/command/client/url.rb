module Command
    module Client
      class Url
        include Requestable

        attr_reader :url, :type

        def initialize(attrs)
          @type = attrs["type"]
          @url = attrs["url"]
        end
      end
    end
  end
