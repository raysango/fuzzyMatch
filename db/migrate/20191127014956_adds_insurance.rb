class AddsInsurance < ActiveRecord::Migration[6.0]
  def up
    create_table :insurances do |t|
      t.string :name
    end
    execute "CREATE INDEX insurances_gin_name ON insurances USING gin(to_tsvector('english', 'name'))"
  end

  def down
    drop_table :insurances
    remove_index :insurances_gin_name
  end
end
