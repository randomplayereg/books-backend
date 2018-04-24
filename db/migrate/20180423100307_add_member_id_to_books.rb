class AddMemberIdToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :member_id, :integer
  end
end
