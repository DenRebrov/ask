class RemoveAnswerFromHashtags < ActiveRecord::Migration[5.1]
  def change
    remove_column :hashtags, :answer, :string
  end
end
