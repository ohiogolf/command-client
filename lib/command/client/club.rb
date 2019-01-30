module Command
  module Client
    class Club < Base
      operation "getclub"

      attr_reader :architect, :cid, :cltid, :club_number, :club_gender, :club_name,
      :club_type, :craid, :handicap_club_type, :number_of_holes, :rid,
      :year_founded, :addresses, :functions, :texts, :urls, :images,
      :facilities, :phones

      def build(attrs)
        @club_number = attrs["club_number"]
        @architect = attrs["architect"]
        @cid = attrs["cid"]
        @cltid = attrs["cltid"]
        @club_gender = attrs["club_gender"]
        @club_name = attrs["club_name"]
        @club_type = attrs["club_type"]
        @craid = attrs["craid"]
        @handicap_club_type = attrs["handicap_club_type"]
        @number_of_holes = attrs["number_of_holes"]
        @rid = attrs["rid"]
        @year_founded = attrs["year_founded"]

        @addresses = Address.many(attrs.dig("addresses", "address"))
        @facilities = []
        @functions = []
        @images = []
        @phones = Phone.many(attrs.dig("phones", "phone"))
        @texts = []
        @urls = Url.many(attrs.dig("urls", "url"))
      end
    end
  end
end
