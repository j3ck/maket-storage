require "rails_helper.rb"

describe Maket do

	let(:version) { FactoryGirl.create(:version) }
	before { @maket = version.makets.build(name: "qwe", 
		image_file_name: "1461078_753442374667900_807820565_a.png",
  	image_content_type: "image/png",
  	image_file_size: 21801,
  	image_updated_at: "2014-02-25 17:57:56",
  	image_fingerprint: "d27a788d309bc8a56314ecc3a8382aa8")
	}

	it { expect(@maket).to respond_to(:name) }
	it { expect(@maket).to respond_to(:version_id) }
	it { expect(@maket).to respond_to(:image) }

	it { expect(@maket).to be_valid }

	describe "should be with blank name" do
		before { @maket.name = "" }
		it { expect(@maket).not_to be_valid }
	end

	describe "should be with blank image" do
		before { @maket.image = nil }
		it { expect(@maket).not_to be_valid }
	end

	describe "valid image_content_type" do
		before { @maket.image_content_type = "mp3" }
		it { expect(@maket).not_to be_valid }
	end
end