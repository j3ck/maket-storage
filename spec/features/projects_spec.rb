require "rails_helper.rb"
include Warden::Test::Helpers
Warden.test_mode!

describe "Projects pages", :type => :feature do

	before { 
		@user = FactoryGirl.create(:user)
		login_as(@user, :scope => :user)
		visit projects_path
	}

	describe "projects path" do

		it { expect(page).to have_content "Вы вошли как #{@user.email}" }
		it { expect(page).to have_content 'Все проекты' }
		it { expect(page).to have_content 'Пользователи' }
		it { expect(page).to have_content 'Проекты' }
		it { expect(page).to have_content 'Название' }
		it { expect(page).to have_content 'Создатель' }

		it "pm not have Users navigation" do
			@user.role = "ProjectManager"
			@user.save
			visit projects_path
			expect(page).not_to have_content 'Пользователи'
		end

		describe "projects_path links" do

			it "have new project link" do
				find_link('Добавить новый проект')
			end

			it "have logout link" do
				find_link('Выйти')
			end

			describe "project links" do

				before {
					@project = @user.projects.build(name: "Prj")
					@project.save
					visit projects_path
				}

				it "have link created project" do
					find_link('Prj')
				end

				it "project link" do
					find_link('Prj').click
					expect(page).to have_content('Prj')
					expect(page).to have_content('Версии')
				end

				it { find_link('Просмотр') }
				it { find_link('Редактирование') }
				it { find_link('Удалить') }
			end
		end
	end

	describe "new project path" do

		before { visit new_project_path }

		it { expect(page).to have_content 'Добавление нового проекта' }
		it { find_button('Добавить проект') }
		it { find_link('Вернуться') }

		it "create project" do
			within("#new_project") do
				fill_in 'Имя проекта', :with => 'capybara'
			end
			click_button 'Добавить проект'
			expect(page).to have_content 'Проект успешно создан!'
		end

		it "created errors with bad name" do
			within("#new_project") do
				fill_in 'Имя проекта', :with => ''
			end
			click_button 'Добавить проект'
			expect(page).to have_selector('div.panel-danger')
			expect(page).to have_content 'Ошибки при сохранении проекта'
			expect(page).not_to have_content 'Проект успешно создан!'
		end
	end

	describe "project path" do

		before { 
			@project = @user.projects.build(name: "Prj")
			@project.save
			visit project_path(@project)
		}

		it { find_link('Вернуться в списку проектов') }
		it { find_button('Добавить новую версию') }
	end
end