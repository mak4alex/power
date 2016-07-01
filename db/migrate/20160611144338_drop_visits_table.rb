class DropVisitsTable < ActiveRecord::Migration
  def up
    drop_table :visits
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
