class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Собираем в массив чьи-то(- это Х) умения
  def skills(x)
    list = []
    x.skills.each {|skill| list << skill.name}
  end

  # Ищем вакансии для сотрудника
  def vacancies_for_employee(employee)
    @employee = employee
    @empl_skills = skills(@employee)
    @vac = Vacancy.all.order("salary DESC")
    @search_result = {}
    @search_result[:all] = []
    @search_result[:any] = []

    @vac.each {|vacancy|
      if vacancy.date_up >= Date.today
        vac_skills = skills(vacancy)
        @search_result[:any] << vacancy if (vac_skills.any? {|elem| @empl_skills.include? elem})
        @search_result[:all] << vacancy if (vac_skills.all? {|elem| @empl_skills.include? elem})
      end
    }
    @search_result
  end

  def full_fit_vacancies(employee)
    @search_result = vacancies_for_employee(employee)
    @vacancies=[]
    @vacancies = @search_result[:all]
  end

  def part_fit_vacancies(employee)
    @search_result = vacancies_for_employee(employee)
    @vacancies=[]
    @vacancies = @search_result[:any]
  end

  # Ищем сотрудников к вакансии
  def employees_for_vacancy(vacancy)
    @vacancy = vacancy
    @vac_skills = skills(@vacancy)
    @empl = Employee.all.order("salary ASC")
    @search_result = {}
    @search_result[:all] = []
    @search_result[:any] = []

    @empl.each {|employee|
      if employee.status == 'yes'
        empl_skills = skills(employee)
        @search_result[:any] << employee if (@vac_skills.any? {|elem| empl_skills.include? elem})
        @search_result[:all] << employee if (@vac_skills.all? {|elem| empl_skills.include? elem})
      end
    }
    @search_result
  end

  def full_fit_employees(vacancy)
    @search_result = employees_for_vacancy(vacancy)
    @employees=[]
    @employees = @search_result[:all]
  end

  def part_fit_employees(vacancy)
    @search_result = employees_for_vacancy(vacancy)
    @employees=[]
    @employees = @search_result[:any]
  end
end
