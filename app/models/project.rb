class Project < ActiveRecord::Base
	belongs_to :user

	validates :name, presence: true
	validates :name, length: { minimum: 2 }
	validates :name, uniqueness: true
end
