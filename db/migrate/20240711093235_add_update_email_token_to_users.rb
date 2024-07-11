class AddUpdateEmailTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :update_email_token, :string
    add_column :users, :update_email_token_sent_at, :datetime
  end
end
