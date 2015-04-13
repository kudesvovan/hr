class RenameContactsColumn < ActiveRecord::Migration
  def change
  	rename_column :employees, :contacts, :email
  end
end
