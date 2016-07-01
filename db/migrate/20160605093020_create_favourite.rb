class CreateFavourite < ActiveRecord::Migration
  def change
    create_table :favourites, id: false do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
    end
    add_index :favourites, [:user_id, :post_id], unique: true
  end
end
