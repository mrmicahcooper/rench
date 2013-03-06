require "rench/version"
require "faraday"

class Rench::CLI

  attr_reader :github_username, :filename, :file_location

  def ask_for_file_location
    $stdout.write "Where do you wanna put \"#{filename}\"? "
    file = build_file_location($stdin.gets.to_s.strip)
    if file == ""
      filename
    else
      file
    end
  end

  def build_file_location(input)
    if input.match /\w+\.\w+/
      input
    elsif input.match /\/$/
      input + filename
    elsif input == ""
      ""
    else
      input + "/" + filename
    end
  end

  def download_file
    response = Faraday.new.get(url)
    if response.status == 200
      system("curl #{url} -o #{file_location} --create-dirs")
      $stdout.puts "=> #{ file_location }"
    else
      $stdout.puts "File not found in #{github_username}'s toolbox"
    end
  end

  def file_location
    @file_location ||=  ask_for_file_location
  end

  def initialize(username, filename, new_file_location = nil)
    @github_username = username
    @filename = filename
    @file_location = new_file_location
  end

  def url
    "https://raw.github.com/#{github_username}/toolbox/master/files/#{filename}"
  end

end
