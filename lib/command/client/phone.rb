module Command
    module Client
      class Phone
        attr_reader :extension, :number, :primary, :type

        def self.many(props)
          [props].compact.flatten.map { |attrs| new(attrs) }
        end

        def initialize(attrs)
          @type = attrs["type"]
          @number = attrs["number"]
          @primary = attrs["primary"]
          @extension = attrs["extension"]
        end
      end
    end
  end
