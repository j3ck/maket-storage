require "rails_helper.rb"
include Warden::Test::Helpers
Warden.test_mode!

describe "sign-in-out pages", :type => :feature do

	before {
		@user = FactoryGirl.create(:user)
		visit root_path
	}

	it { expect(page).to have_content('Вход') }
	it { expect(page).to have_content('Maket storage') }
	it { expect(page).to have_button('Войти') }

	it "success sign_in" do
		within("#new_user") do
			fill_in 'Email адрес', :with => "#{@user.email}"
			fill_in 'Пароль', :with => 123123123
		end
		click_button 'Войти'
		expect(page).to have_content('Вы успешно вошли.')
	end

	it "invalid sign_in" do
		within("#new_user") do
			fill_in 'Email адрес', :with => ""
		end
		click_button 'Войти'
		expect(page).to have_content('Неверный email адрес или пароль.')
	end

	it "sign_out" do
		login_as(@user, :scope => :user)
		visit root_path
		click_link('Выйти')
		expect(page).to have_content('Вы вышли.')
	end
end