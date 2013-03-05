require "wrench/version"
require "faraday"

class Wrench::CLI

  attr_reader :github_username, :filename, :file_location

  def initialize(username, filename, new_file_location = nil)
    @github_username = username
    @filename = filename
    @file_location = new_file_location
  end

  def download_file
    Faraday.new.get(url)
  end

  def file_location
    @file_location ||=  ask_for_file_location
  end

  def ask_for_file_location
    p "Where do you wanna put the file? (leave blank to keep the same)"
    file = $stdin.gets.strip
    filename if file == ""
  end

  def url
    "https://raw.github.com/#{github_username}/toolbox/master/files/#{filename}"
  end

end
