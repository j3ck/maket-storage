FactoryGirl.define do
	factory :user do
    	sequence(:email) { |n| "person_#{n}@example.com"}
    	password "123123123"
    	password_confirmation "123123123"
  	end

  factory :project do
  	name "Lorem ipsum"
  	user
  end

  factory :version do
  	name "v1"
  	project
  end
end