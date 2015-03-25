class CreateSkillsVacancies < ActiveRecord::Migration
  def change
    create_table :skills_vacancies do |t|
    	t.integer :skill_id
    	t.integer :vacancy_id
    end
  end
end
