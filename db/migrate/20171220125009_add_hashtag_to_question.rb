class AddHashtagToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :hashtag, :string
  end
end
