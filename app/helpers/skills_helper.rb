module SkillsHelper

	def skills_id(skills)
		@skills_id = []
		skills.each do |skill|
			@skills_id << skill.id
		end
		@skills_id
	end

end
