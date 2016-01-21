module Tweeter
    class FileService
        LOCATON = 'app/public/uploads/'
        
        def self.transfer(temp_file, filename)
            timestamp = Time.now.utc.iso8601
            path = "#{LOCATON}#{timestamp}-#{filename}"
            file = File.new(path, 'w')
            File.open(temp_file, 'r') do |f|
                file.write f.read
            end
            file.close
            path
        end
    end
end