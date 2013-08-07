require "rench/version"
require "highline"
require "faraday"
require 'json'
require 'readline'

class Rench::CLI

  attr_accessor :filename

  def crank
    system("curl #{url} -o #{file_location} --create-dirs")
  end

  def initialize(username = nil, filename = nil, new_file_location = nil)
    @github_username = username
    @filename = filename
    @file_location = new_file_location
  end

  def github_username
    @github_username ||= highline.ask "Enter a Github username"
  end

  def filename
    @filename ||= highline.choose(tool_menu)
  end

  def tool_menu
    toolbox.map{|tool| tool["name"]}
  end

  def file_location
    @file_location ||= choose_file_location
  end

  def choose_file_location
    highline.ask("Where do you want to download the file?", file_options) do |question|
      question.readline = true
      question.answer_type = String
    end
  end

  def highline
    @highline ||= HighLine.new
  end

private

  def file_options
    Dir.glob("**/*")
  end

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
