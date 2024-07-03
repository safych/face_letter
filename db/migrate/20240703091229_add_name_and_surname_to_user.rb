class AddNameAndSurnameToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :surname, :string, null: false, default: ""
  end
end
