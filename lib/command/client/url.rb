module Command
    module Client
      class Url
        attr_reader :url, :type

        def self.many(props)
          [props].compact.flatten.map { |attrs| new(attrs) }
        end

        def initialize(attrs)
          @type = attrs["type"]
          @url = attrs["url"]
        end
      end
    end
  end
