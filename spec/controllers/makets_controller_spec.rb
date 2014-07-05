require "rails_helper.rb"

describe MaketsController do

	before {
		@version = FactoryGirl.create(:version)
		sign_in :user, @version.project.user
		@attr = {
			name: "Maket",
			version_id: @version.id,
			image_file_name: "1461078_753442374667900_807820565_a.png",
			image_content_type: "image/png",
			image_file_size: 21801,
			image_updated_at: "2014-02-25 17:57:56",
			image_fingerprint: "d27a788d309bc8a56314ecc3a8382aa8"
		}
			@maket = Maket.create(@attr)
			@maket.save
	}

	describe "GET show" do

		it "sould be success response" do
			get :show, :id => @maket.image_fingerprint
			expect(response).to be_success
		end

		it "render show template" do
			get :show, :id => @maket.image_fingerprint
			expect(response).to render_template(:show)
		end
	end

	it "DELETE destory" do
		delete :destroy, :id => @maket.image_fingerprint
		expect(response.status).to eq(302)
	end

	it "ajax POST create" do
		xhr :post, :create, maket: @attr
		expect(response).to be_success
	end
end