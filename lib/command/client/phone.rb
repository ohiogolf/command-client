module Command
    module Client
      class Phone
        include Requestable

        attr_reader :extension, :number, :primary, :type

        def initialize(attrs, compact: false)
          if compact
            build_compact(attrs)
          else
            build_general(attrs)
          end
        end

        def build_compact(attrs)
          @extension = attrs["extension"]
          @number = attrs["phone"]
          @type = attrs["phone_type"]
        end

        def build_general(attrs)
          @extension = attrs["extension"]
          @number = attrs["number"]
          @primary = attrs["primary"]
          @type = attrs["type"]
        end

        def worthless?
          number.nil?
        end
      end
    end
  end
