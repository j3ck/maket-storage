require "rails_helper.rb"

describe MaketsController do

	before {
				@maket = Maket.create(name: "Maket", 
			image_file_name: "1461078_753442374667900_807820565_a.png",
			image_content_type: "image/png",
			image_file_size: 21801,
			image_updated_at: "2014-02-25 17:57:56",
			image_fingerprint: "d27a788d309bc8a56314ecc3a8382aa8")
			@maket.save
	}

	it "GET show" do
		get :show, :id => @maket.id
		expect(response).to be_success
	end
end