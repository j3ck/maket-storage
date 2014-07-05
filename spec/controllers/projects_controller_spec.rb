require "rails_helper.rb"
require "cancan/matchers"

describe ProjectsController do

	before {
		@user = FactoryGirl.create(:user)
		sign_in @user
		@project = @user.projects.build(name: "Name")
		@project.save
	}

	describe "GET show" do

		it "should be success" do
			get :show, :id => @project.id
			expect(response).to be_success
		end

		it "should render show template" do
			get :show, :id => @project.id
			expect(response).to render_template(:show)
		end
	end

	describe "GET destroy" do
		it "should be http success" do
			get 'destroy', :id => @project.id
			expect(response.status).to eq(302)
		end
	end

	describe "GET index" do
		it "should be http success" do
			get :index
			expect(response).to be_success
		end

		it "render index template" do
			get :index
			expect(response).to render_template(:index)
		end
	end
end