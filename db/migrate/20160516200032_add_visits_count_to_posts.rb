class AddVisitsCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :visits_count, :integer
  end
end
