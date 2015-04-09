class Vacancy < ActiveRecord::Base
	has_and_belongs_to_many :skills

	def self.search(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
end
