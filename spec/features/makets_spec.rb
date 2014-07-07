require "rails_helper.rb"
include Warden::Test::Helpers
Warden.test_mode!

describe "Makets pages", :type => :feature do

	before {
		@version = FactoryGirl.create(:version)
		login_as(@version.project.user, :scope => :user)
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
		visit project_version_path(:project_id => @version.project.id, :id => @version.id)
	}

	it { expect(page).to have_content('Макеты') }
	it { expect(page).to have_content("#{@maket.name}") }
	it { find_button('Добавить макет') }
	it { find_link('Вернуться к версиям') }
	it { find_link('Просмотр') }
	it { find_link('Скопировать в буффер обмена') }
	it { find_link('Удалить') }

	it "errors maket" do
		within("#new_maket") do
			fill_in 'Название макета', :with => ''
		end
		click_button('Добавить макет')
		expect(page).to have_content('Ошибки при сохранении проекта')
	end

	it "create maket" do
		within("#new_maket") do
			fill_in 'Название макета', :with => 'poiu'
			find('#maket_image').set(File.join(Rails.root, 'public/system/5d71dc51d4407955bfe03a9e74a0b10553c2d91e.jpg'))
		end
		click_button('Добавить макет')
		expect(page).to have_content('poiu')
	end

	it "maket path" do
		visit maket_path(@maket)
		expect(page).to have_selector('img')
	end
end