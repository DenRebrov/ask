class AddAnswerToHashtags < ActiveRecord::Migration[5.1]
  def change
    add_column :hashtags, :answer, :string
  end
end
