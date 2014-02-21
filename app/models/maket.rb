class Maket < ActiveRecord::Base
	belongs_to :version

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

	has_attached_file :image, {
    :url => "/system/:hash.:extension",
    :hash_secret => "longSecretString"
}

	validates :name, presence: true
	validates :name, length: { minimum: 1 }
	validates :image, presence: true
	validates :image_fingerprint, uniqueness: true

	def to_param
		image_fingerprint
	end
end
