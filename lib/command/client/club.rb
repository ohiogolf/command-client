module Command
  module Client
    class Club
      include Requestable

      operation "getclub"

      attr_reader :architect, :cid, :cltid, :club_number, :club_gender, :club_name,
      :club_type, :craid, :handicap_club_type, :number_of_holes, :rid,
      :year_founded, :addresses, :functions, :texts, :urls, :images,
      :facilities, :phones

      def self.search(params={})
        query = { facility: "''" }.merge(params)
        request = Request.new(operation: "searchclub", params: query).call
        club_attributes = request.result.dig("clubs", "club")
        many(club_attributes)
      end

      def initialize(attrs={})
        @architect = attrs["architect"]
        @cid = attrs["cid"]
        @cltid = attrs["cltid"]
        @club_gender = attrs["club_gender"]
        @club_name = attrs["club_name"]
        @club_number = attrs["club_number"]
        @club_type = attrs["club_type"]
        @craid = attrs["craid"]
        @handicap_club_type = attrs["handicap_club_type"]
        @number_of_holes = attrs["number_of_holes"]
        @rid = attrs["rid"]
        @year_founded = attrs["year_founded"]
        @facilities = []
        @functions = []
        @images = []
        @texts = []
        @urls = Url.many(attrs.dig("urls", "url"))

        @addresses = if attrs["addresses"]
          Address.many(attrs.dig("addresses", "address"))
        else
          Address.many(attrs)
        end

        @phones = if attrs["phones"]
          Phone.many(attrs.dig("phones", "phone"), compact: false)
        else
          Phone.many(attrs, compact: true)
        end
      end
    end
  end
end
