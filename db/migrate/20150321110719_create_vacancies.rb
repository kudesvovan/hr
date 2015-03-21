class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :name
      t.date :date_in
      t.date :date_up
      t.integer :salary
      t.string :contacts
      t.text :skills

      t.timestamps
    end
  end
end
