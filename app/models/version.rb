class Version < ActiveRecord::Base
	belongs_to :project
	has_many :makets, dependent: :destroy

	validates :name, presence: { message: "не может быть пустым" }
	validates :name, length: { minimum: 2, message: "длина должна быть минимум два символа" }
end
