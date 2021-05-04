class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.text :description
      t.boolean :private
      t.string :token
      t.string :image
      t.string :background_image

      t.timestamps
    end
  end
end
