module ApplicationHelper
	def skills(x)
		list = []
		x.skills.each {|skill| list << skill.name}
		list.join(', ')
  end
end
