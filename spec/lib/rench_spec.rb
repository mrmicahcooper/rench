require 'rench'

describe Rench::CLI do

  let(:github_user) { "mrmicahcooper" }

  subject { described_class.new(github_user, 'active_record_spec_helper.rb') }

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

  describe "#url" do
    it "builds the github url" do
      subject.url.should == "https://raw.github.com/mrmicahcooper/toolbox/master/files/active_record_spec_helper.rb"
    end
  end

end
