require "rails_helper.rb"
include Warden::Test::Helpers
Warden.test_mode!

describe "Versions pages", :type => :feature do

	before {
		@user = FactoryGirl.create(:user)
		login_as(@user, :scope => :user)
		@project = @user.projects.build(name: "Project")
		@project.save
		@version = @project.versions.build(name: "v1")
		@version.save
		visit project_path(@project)
	}

	describe "all versions" do

		it { expect(page).to have_content('Все проекты') }
		it { expect(page).to have_content('Версии') }
		it { expect(page).to have_content('v1') }
		it { expect(page).to have_content('Удалить') }
		it { expect(page).to have_content('Просмотр') }
		it { find_link('v1') }

		it "errors create version" do
			within("#new_version") do
				fill_in 'Тег версии', :with => ''
			end
			click_button('Добавить новую версию')
			expect(page).to have_content('Ошибки при сохранении версии')
		end

		it "create version" do
			within("#new_version") do
				fill_in 'Тег версии', :with => 'ver'
			end
			click_button('Добавить новую версию')
			expect(page).to have_content('ver')
		end
	end
end