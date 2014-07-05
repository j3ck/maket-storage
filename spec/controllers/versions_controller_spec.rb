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

	describe "DELETE destory" do
		it "delete status" do
			delete :destroy, { :project_id => @version.project.id, :id=> @version.id }
			expect(response.status).to eq(302)
		end
	end

	describe "POST create" do
		it "post success status" do
			xhr :post, :create, { :project_id => @version.project.id, :version => { name: "Vers", project_id: @version.project.id } }
			expect(response).to be_success
		end
	end
end