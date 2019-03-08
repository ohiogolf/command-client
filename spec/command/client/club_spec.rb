RSpec.describe Command::Client::Club, :vcr do

  context ".search" do
    let(:clubs) { Command::Client::Club.search(club_name: club_name) }

    describe "has no matches" do
      let(:club_name) { "Football of America" }

      it "returns an empty array" do
        expect(clubs.size).to eq(0)
      end

    end

    describe "has multiple matches" do
      let(:club_name) { "Test Club" }

      it "builds an array of clubs" do
        expect(clubs.size).to eq(3)
        expect(clubs.all? { |c| c.is_a?(Command::Client::Club) }).to eq(true)
        expect(clubs.first.club_name).to eq("Test Club Aaron 1")
      end
    end
  end


  context ".find" do
    let(:club) { Command::Client::Club.find(club_number: club_number) }

    describe "has multiple addresses, phones" do
      let(:club_number) { 999614 }

      it "finds and builds the club" do
        aggregate_failures do
          expect(club.club_name).to eq("Test Club Aaron 1")
          expect(club.club_number).to eq("999614")
          expect(club.architect).to eq("Test Architect")
          expect(club.number_of_holes).to eq("99")
          expect(club.addresses.size).to eq(2)
          expect(club.phones.size).to eq(2)
          expect(club.urls.size).to eq(2)
        end
      end
    end

    describe "has one address, phone" do
      let(:club_number) { 999615 }

      it "finds and builds the club" do
        aggregate_failures do
          expect(club.club_name).to eq("Test Club Aaron 2")
          expect(club.club_number).to eq("999615")
          expect(club.addresses.size).to eq(1)
          expect(club.phones.size).to eq(1)
          expect(club.urls.size).to eq(1)
        end
      end
    end

    describe "has no address, phone" do
      let(:club_number) { 999616 }

      it "finds and builds the club" do
        aggregate_failures do
          expect(club.club_name).to eq("Test Club Aaron 3")
          expect(club.club_number).to eq("999616")
          expect(club.addresses.size).to eq(0)
          expect(club.phones.size).to eq(0)
          expect(club.urls.size).to eq(0)
        end
      end
    end
  end

  context ".all" do
    it "returns all Clubs from Command" do
      expect(Command::Client::Club.all.size).to be > 30
    end
  end
end
