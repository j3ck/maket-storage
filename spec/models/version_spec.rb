require "rails_helper.rb"

describe Version do

	let(:project) { FactoryGirl.create(:project) }
	before { @version = project.versions.build(name: "Version_1") }

	it { expect(@version).to respond_to(:name)}
	it { expect(@version).to respond_to(:project_id)}
	it { expect(@version).to respond_to(:project) }

	it { expect(@version).to be_valid }

	describe "should be with blank name" do
		before { @version.name = "" }
		it { expect(@version).not_to be_valid }
	end

	describe "name hould be greater than or equal to 2" do
		before { @version.name = "a" }
		it { expect(@version).not_to be_valid }
	end
end