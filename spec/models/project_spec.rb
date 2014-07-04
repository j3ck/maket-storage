require "rails_helper.rb"

describe Project do

	before do
		@attr = {
			:name => "Test",
			:user_id => 1
		}
		@project = Project.create!(@attr)
	end

	it { expect(@project).to respond_to(:name)}
	it { expect(@project).to respond_to(:user_id)}
	it { expect(@project).to be_valid }

	it "should create a new instance with valid attributes" do
		expect(@project.save).to be == true
	end

	describe "when user_id is not present" do
		before { @project.user_id = nil }
		it { expect(@project).not_to be_valid }
	end

	describe "should be with blank name" do
		before { @project.name = "" }
		it { expect(@project).not_to be_valid }
	end

	describe "should be greater than or equal to 2" do
		before { @project.name = "a" }
		it { expect(@project).not_to be_valid }
	end
end