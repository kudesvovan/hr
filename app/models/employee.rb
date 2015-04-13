class Employee < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
	has_and_belongs_to_many :skills
	VALID_NAME_REGEX = /\A[а-я]+\s[а-я]+\s[а-я]+\z/i
	validates :name, format: {with: VALID_NAME_REGEX}, presence: {message: "Введите ФИО полностью через пробел"}
	validates :status, presence: {message: "Статус обязателен к заполнению"}

	def self.search(search)
    if search
	    includes(:skills).where('skills.name LIKE ?', "%#{search}%").references(:skills)
	  else
	  	scoped 
	  end
	end
end