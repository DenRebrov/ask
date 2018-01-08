class RemoveHashtagFromQuestion < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :hashtag, :string
  end
end
