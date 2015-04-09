class Skill < ActiveRecord::Base
	has_and_belongs_to_many :employees
	has_and_belongs_to_many :vacancies

	validates :name, uniqueness: true

	def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
	end
end
