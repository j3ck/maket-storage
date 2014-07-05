require "rails_helper.rb"

describe UsersController do

	before {
		@user = FactoryGirl.create(:user)
		sign_in :user, @user
	}


	describe "index" do

		it "get success response" do
			get :index
			expect(response).to be_success
		end

		it "render template" do
			get :index
			expect(response).to render_template(:index)
		end
	end
end