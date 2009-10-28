require 'open-uri'
require 'tmpdir'

# Buffered download class, this takes a uri and grabs the file returning the temp file it downloaded to
module Feeder
  class Puller
    # Download from the uri buffering by buffer_size bytes
    #
    # @example Download a file with a custom buffer size
    #   file_location = Feeder::Puller.fetch('http://www.example.com/my_feed.xml', 16384)
    #
    # @param [String] the uri to pull from
    # @param [Integer] the size of the buffer
    # @return [String] the file location where the download was placed
    def self.fetch(uri, buffer_size = 8192)
      filename = File.join(Dir.tmpdir, File.basename(uri))
      open(uri) do |fin|
        open(filename, "w") do |fout|
          while (buf = fin.read(buffer_size))
            fout.write buf
          end
        end
      end
      filename
    end
  end
end