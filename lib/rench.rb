require "rench/version"
require "faraday"
require 'json'

class Rench::CLI

  attr_reader :github_username, :filename, :file_location
  attr_accessor :toolbox

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

  def chosen_file
    print_renches
    chosen_file = $stdin.gets.to_i
    self.toolbox[chosen_file]
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

  def filename
    @filename ||= chosen_file
  end

  def initialize(username, filename = nil, new_file_location = nil)
    @github_username = username
    @filename = filename
    @file_location = new_file_location
  end

  def print_renches
    $stdout.puts "Choose a file"
    toolbox.each_with_index do |tool, i|
      $stdout.puts "[#{i}] #{tool}"
    end
  end

  def toolbox
    toolbox_response.map{|tool_file| tool_file["name"] }
  end

  def toolbox_response
    @toolbox_response ||= response = JSON.parse(Faraday.get(toolbox_url).body)
  end

  def url
    "https://raw.github.com/#{github_username}/toolbox/master/files/#{filename}"
  end

  def toolbox_url
    "https://api.github.com/repos/#{github_username}/toolbox/contents/files"
  end

end
