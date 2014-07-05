require "rails_helper.rb"
require "cancan/matchers"

describe VersionsController do

before {
	@version = FactoryGirl.create(:version)
	sign_in :user, @version.project.user
}

	describe "GET show" do
		it "get success status" do
			get :show, { :project_id => @version.project_id, :id => @version.id }
			expect(response).to be_success
		end

		it "render show template" do
			get :show, { :project_id => @version.project_id, :id => @version.id }
			expect(response).to render_template(:show)
		end
	end
end