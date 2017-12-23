class AddHeadcolorToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :head_color, :string
  end
end
