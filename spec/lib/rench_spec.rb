require 'rench'

describe Rench::CLI do
  let(:rench) { Rench::CLI.new "mrmicahcooper", "file.txt" }
  let(:highline) { rench.highline }

  describe "#crank" do
    after{ File.delete 'tmp/thing.rb' }

    let(:rench) do
      Rench::CLI.new('mrmicahcooper', 'ui_controller.rb', 'tmp/thing.rb')
    end

    it "downloads the file" do
      rench.crank
      File.read('tmp/thing.rb').should_not == ""
    end

  end

  describe "#github_username" do
    context "when NOT initialized with a username" do
      let(:rench) { Rench::CLI.new }
      it "prompts for username" do
        highline.should_receive(:ask).with("Enter a Github username")
        rench.github_username
      end
    end

    context "when initialized with a username" do
      it "doesn't prompt for username" do
        highline.should_not_receive(:ask)
        rench.github_username
      end
    end
  end

  describe "#filename" do
    context "when NOT initialized with filename" do
      let(:rench) { Rench::CLI.new "mrmicahcooper" }
      it "asks to choose a file from the tool menu" do
        tools = []
        highline.should_receive(:choose).with(tools)
        rench.should_receive(:tool_menu).and_return(tools)
        rench.filename
      end
    end
    context "when initialized with filename" do
      it "does not ask to choose a file" do
        highline.should_not_receive(:choose)
        rench.filename
      end
    end
  end

  describe "#tool_menu" do
    context "when there are no tools" do
      before do
        response = double(status: 400, body: "")
        Faraday::Connection.any_instance.stub(get: response)
      end
      it "returns a 'no tools' message" do
        highline.should_receive(:say).with("No toolbox found for mrmicahcooper")
        begin
          rench.tool_menu
        rescue SystemExit
        end
      end
    end

    context "when there are tools" do
      before do
        response = double(status: 200, body: '[{"name":"tool.txt"}]')
        Faraday::Connection.any_instance.stub(get: response)
      end
      it "returns an array of tool names" do
        rench.tool_menu.should == ["tool.txt"]
      end
    end
  end

  describe "#file_location" do
    context "when intialized with a filename" do
      let(:rench) { Rench::CLI.new('mrmichacooper', "", "/location") }
      it "uses the passed in file_location" do
        rench.file_location.should == "/location"
      end
    end
    context "when NOT initialize with a file location" do
      let(:rench) { Rench::CLI.new('mrmichacooper', "" ) }
      it "asks for a location" do
        rench.should_receive(:choose_file_location)
        rench.file_location
      end
    end
  end

  describe "#choose_file_location" do
    it "asks where to put the file" do
      rench.highline.should_receive(:ask)
      rench.choose_file_location
    end
  end

end
