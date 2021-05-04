class ChangeDataContentToMessage < ActiveRecord::Migration[5.2]
  def change
    change_column :messages, :content, :text
  end
end
