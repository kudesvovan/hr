class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :contacts
      t.string :status
      t.integer :salary
      t.text :skills

      t.timestamps
    end
  end
end
