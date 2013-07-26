require "rench/version"
require "highline"
require "faraday"
require 'json'

class Rench::CLI

  attr_reader :github_username, :filename, :file_location

  def crank
    ask_for_username
    choose_file
    #check toolbox for file
    #download tool
  end

  def initialize(username = nil, filename = nil, new_file_location = nil)
    @github_username = username
    @filename = filename
    @file_location = new_file_location
  end

  def ask_for_username
    @github_username ||= highline.ask "Enter a Github username"
  end

  def choose_file
    @filename ||= highline.choose(tool_menu)
  end

  def tool_menu
    highline.say("No tools found for #{@github_username}")
  end

  def highline
    @highline ||= HighLine.new
  end

private

  def url
    "http://raw.github.com/#{github_username}/toolbox/master/tools/#{filename}"
  end

  def toolbox_url
    "http://api.github.com/repos/#{github_username}/toolbox/contents/tools"
  end

end

__END__

    # response = Faraday.new.get(url)
    # if response.status == 200
    #   system("curl #{url} -o #{file_location} --create-dirs")
    #   # $stdout.puts "=> #{ file_location }"
    # else
    #   # $stdout.puts "File not found in #{github_username}'s toolbox"
    # end
