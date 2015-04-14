module ApplicationHelper
	def skills(x)
		list = []
		x.skills.each {|skill| list << skill.name}
		list.join(', ')
  end

  
  def contacts(employee)
    email = employee.email
    phone = employee.phone
    contacts = []

    # почты нет, тел есть
    if email.nil? && !phone.nil?
    	contacts << phone
    # почты нет, тел нет
    elsif email.nil? && phone.nil?
    	contacts
    # почта есть, тел нет
    elsif !email.nil? && phone.nil?
    	contacts << email
    # почта есть, тел есть
    elsif !email.nil? && !phone.nil?
    	contacts << email
    	contacts << phone
    end
    contacts.join(', ')
  end
end
