require 'wrench'

describe Wrench::CLI do

  let(:github_user) { "mrmicahcooper" }

  subject { described_class.new(github_user, 'active_record_spec_helper.rb') }

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

  describe "#download_file" do
    before { $stdin.stub(gets: "text.txt") }

    context "when file is found" do
      it "downloads the specified tool file" do
        subject.download_file.should_not be_nil
      end
      it "saves saves it"
    end

    context "when file is not found" do
      let(:github_user) { "someone_else" }
      it "returns message that file was not found" do
        subject.download_file.should == "Github file not found"
      end
    end

  end
end
