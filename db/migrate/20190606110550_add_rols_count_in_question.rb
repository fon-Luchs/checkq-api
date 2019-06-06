class AddRolsCountInQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :rolls_count, :integer, default: 0
  end
end
