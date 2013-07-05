require "rench/version"
require "highline"
require "faraday"
require 'json'

class Rench::CLI

  attr_reader :github_username, :filename, :file_location


  def download_file
    response = Faraday.new.get(url)
    if response.status == 200
      system("curl #{url} -o #{file_location} --create-dirs")
      $stdout.puts "=> #{ file_location }"
    else
      $stdout.puts "File not found in #{github_username}'s toolbox"
    end
  end


  def initialize(username = nil, filename = nil, new_file_location = nil)
    @github_username = username
    @filename = filename
    @file_location = new_file_location
  end

end
