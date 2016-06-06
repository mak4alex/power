class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :file
      t.string :alt

      t.timestamps null: false
    end
  end
end
