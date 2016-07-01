class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|
      t.string :name
      t.string :email
      t.string :topic
      t.text :body
    end
  end
end
