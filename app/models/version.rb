class Version < ActiveRecord::Base
	belongs_to :project
	has_many :makets

	validates :name, presence: true
	validates :name, length: { minimum: 2 }
end
