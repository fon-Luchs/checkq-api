class AddNewColumnsInQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :success_atempts, :integer, default: 0

    add_column :questions, :fail_atempts, :integer, default: 0

    add_column :questions, :rate, :integer, default: 0
  end
end
