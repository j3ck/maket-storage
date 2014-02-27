class Project < ActiveRecord::Base
	belongs_to :user
	has_many :versions, dependent: :destroy

	validates :name, presence: { message: "не может быть пустым" }
	validates :name, length: { minimum: 2, message: "длина должна быть минимум два символа" }
	validates :name, uniqueness: { message: "такое название уже существует" }
end
