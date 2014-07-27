class IMDBImporter

  def self.import(path)
    File.open path do |file|
      file.readlines do |line|
        # Implement this
      end
    end
  end

end