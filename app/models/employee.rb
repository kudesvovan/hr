class Employee < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
	has_and_belongs_to_many :skills
	VALID_NAME_REGEX = /\A[а-я]+\s[а-я]+\s[а-я]+\z/i
	validates :name, format: {with: VALID_NAME_REGEX}, presence: {message: "Введите ФИО полностью через пробел"}
	validates_email_format_of :email, message: 'Не корректный адрес эл.почты'
	validates :status, presence: {message: "Статус обязателен к заполнению"}
	validates :phone, format: { with: /\(\d{3}\)\d{3}-\d{2}-\d{2}/, message: "Введите номер телефона в формате: (XXX)XXX-XX-XX" }

	def self.search(search)
    if search
	    joins(:skills).where('skills.name LIKE ?', "%#{search}%").distinct#.references(:skills)
	  else
	  	scoped 
	  end
	end
end