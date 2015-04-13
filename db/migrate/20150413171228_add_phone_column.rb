class AddPhoneColumn < ActiveRecord::Migration
  def change
  	add_column :employees, :phone, :string
  end
end
