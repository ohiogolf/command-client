module Command
    module Client
      class Address
        include Requestable

        attr_reader :city, :country, :primary, :state, :street1, :street2,
        :street3, :type, :zip

        def initialize(attrs)
          @type = attrs["type"]
          @primary = attrs["primary"]

          @street1 = attrs["street1"]
          @street2 = attrs["street2"]
          @street3 = attrs["street3"]
          @city = attrs["city"]
          @state = attrs["state"]
          @zip = attrs["zip"]
          @country = attrs["country"]
        end

        def worthless?
          city.nil?
        end
      end
    end
  end
