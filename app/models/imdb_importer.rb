# Parse data from "ratings.list" file from IMDB
#
# Data sample (headers not shown):
#
#      0....11303      20   8.1  Here Be Dragons (2013)
#      0...110..5      12   7.5  Here Build Your Homes (2012)
#      0000011112     891   7.1  Here Come the Co-eds (1945)
#
class IMDBImporter

  PARTS = { "I" => 1, "II" => 2, "III" => 3, "IV" => 4, "V" => 5, "VI" => 6 }

  def self.import

    File.open "#{Rails.root}/data/ratings.list", "r", encoding: "Windows-1252" do |file|
      loop do
        break if file.readline == "MOVIE RATINGS REPORT\n"
      end

      # Skip blank line
      file.readline

      # Skip "New  Distribution  Votes  Rank  Title" line
      file.readline 

      # Iterate real data
      counter = 0
      loop do
        counter += 1
        line = file.readline
        print counter
        print "  "
        puts line.squish
        matches = line.squish.match /(?<distribution>[\d\*\.]{10}) (?<votes>\d+) (?<rating>\d?\d\.\d) (?<title>.+) \((?<year>\d\d\d\d|\?\?\?\?)(\/(?<yearpart>\S+))?\)/
        break unless matches
        if !matches[:title].starts_with?('"') && 
          matches[:votes].to_i >= 100 &&
          !line.include?("(TV)") &&
          !line.include?("(V)") &&
          !line.include?("(VG)")
          puts matches[:yearpart]
          Movie.create! title: matches[:title],
                        votes: matches[:votes],
                        rating: matches[:rating],
                        votes_distribution: matches[:distribution],
                        year: matches[:year],
                        year_part: PARTS[matches[:yearpart]]
        end
      end

    end

  end

end
