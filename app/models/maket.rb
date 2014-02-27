class Maket < ActiveRecord::Base
	belongs_to :version

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

	has_attached_file :image, {
    :url => "/system/:hash.:extension",
    :hash_secret => "longSecretString"
}

	validates :name, presence: { message: "не может быть пустым" }
	validates :name, length: { minimum: 1, message: "длина должна быть минимум один символ" }
	validates :image, presence: { message: "не может быть пустым" }
	validates :image_fingerprint, uniqueness: { message: "такой макет уже существует" }

	def to_param
		image_fingerprint
	end
end
