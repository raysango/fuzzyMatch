class AddsInsuranceMatches < ActiveRecord::Migration[6.0]
  def up
    create_table :insurance_matches do |t|
      t.string :name, index: true
      t.references :insurance
    end
  end

  def down
    drop_table :insurance_matches
  end
end
