require 'rench'

describe Rench::CLI do

  let(:github_user) { "mrmicahcooper" }

  subject { described_class.new(github_user, 'active_record_spec_helper.rb') }

  describe "#ask_for_github_username" do
    before { $stdin.stub(gets: "micah") }
    it "asks for a username" do
      subject.ask_for_github_username.should == "micah"
    end
  end

  describe "build_file_location" do
    context "when input ends with a slash" do
      it "contactinates the string with the filename" do
        subject.build_file_location("app/").should == "app/active_record_spec_helper.rb"
      end
    end
    context "when the input has no file extension" do
      it "joins the input and filename with a '/'" do
        subject.build_file_location("app").should == "app/active_record_spec_helper.rb"
      end
    end
    context "when the input has a file extension" do
      it "returns just the input" do
        subject.build_file_location("app.rb").should == "app.rb"
      end
    end
    context "when input is blank" do
      it "returns blank" do
        subject.build_file_location("").should == ""
      end
    end
  end

  describe "#chosen_file" do
    before do 
      subject.stub(toolbox: ["form_builder.rb"])
      $stdin.stub(gets: "0")
    end
    it "returns a a list of tools from that github_user" do
      subject.chosen_file.should == "form_builder.rb"
    end
  end

  describe "#download_file" do
    context "when file is found" do
      before { $stdin.stub(gets: "text.txt") }
      it "downloads the specified tool file" do
        subject.download_file
        File.read("text.txt").should be
        File.delete("text.txt")
      end
    end

    context "when file is not found" do
      before { $stdin.stub(gets: "text.txt") }
      let(:github_user) { "someone_else" }
      it "returns message that file was not found" do
        $stdout.should_receive(:puts).with("File not found in someone_else's toolbox")
        subject.download_file
      end
    end

    context "when choosing a new directory" do
      before { $stdin.stub(gets: "app/text.txt") }
      it "creates the director(y|ies)" do
        subject.download_file
        File.read("app/text.txt").should be
        FileUtils.rm_r("app/text.txt")
      end
    end
  end

  describe '#new' do
    it "knows the github username" do
      subject.github_username.should_not be_nil 
    end
    it "knows the filename" do
      subject.filename.should_not be_nil
    end
  end

  describe "#print_renches" do

    context "when toolbox is empty" do
      before do
        subject.stub(tools_found?: false)
        Kernel.stub(:abort)
      end
      it "exits with a toolbox not found message" do
        Kernel.should_receive(:abort).with("No tools found for \"mrmicahcooper\"")
        subject.print_renches
      end
    end

    context "when toolbox is not empty" do
      before do
        subject.stub(toolbox: ["file.rb", "file2.rb"])
        subject.stub(tools_found?: true)
      end
      it "prints a list of all the renches with a number next to it" do
        $stdout.should_receive(:puts).at_least(3)
        subject.print_renches
      end
    end

  end

  describe "#toolbox" do
    it "returns a collection of filenames from the github users toolbox repo" do
      subject.toolbox.size.should > 2
      subject.toolbox.inspect.should match /ui_controller.rb/
    end
  end

  describe "#tool_found?" do
    let(:github_user) { "121ivesnv" }
    it "returns false if no toolbox is found" do
      subject.tools_found?.should be_false
    end
  end

  describe "#toolbox_url" do
    it "builds the toolbox_url" do
      subject.toolbox_url.should == "https://api.github.com/repos/mrmicahcooper/toolbox/contents/files"
    end
  end

  describe "#url" do
    it "builds the github url" do
      subject.url.should == "https://raw.github.com/mrmicahcooper/toolbox/master/files/active_record_spec_helper.rb"
    end
  end

end
