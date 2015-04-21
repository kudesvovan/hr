class Skill < ActiveRecord::Base
	has_and_belongs_to_many :employees
	has_and_belongs_to_many :vacancies

	validates :name, uniqueness: true

	def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
	end

	def self.to_csv(options={})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |skill|
				csv << skill.attributes.values_at(*column_names)
			end
		end
	end

end
