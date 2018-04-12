class AddTokenAndTokenTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token, :string
    add_column :users, :token_created_at, :datetime
  end
end
