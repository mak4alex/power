class AddDefaultValueToVisitsCount < ActiveRecord::Migration
  def up
    change_column :posts, :visits_count, :integer, default: 0
  end
  
  def down
    change_column :profiles, :visits_count, :integer, default: nil
  end
end
