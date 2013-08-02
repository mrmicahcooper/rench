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
    toolbox.map{|tool| tool["name"]}
  end

  def highline
    @highline ||= HighLine.new
  end

private

  def response
    @response ||= Faraday.new.get(toolbox_url).tap do |resp|
      if resp.status != 200
        highline.say("No toolbox found for #{@github_username}")
        exit
      end
    end
  end

  def toolbox
    @toolbox ||= JSON.parse(response.body)
  end

  def toolbox_url
    "https://api.github.com/repos/#{github_username}/toolbox/contents/tools"
  end

  def url
    "https://raw.github.com/#{github_username}/toolbox/master/tools/#{filename}"
  end

end
