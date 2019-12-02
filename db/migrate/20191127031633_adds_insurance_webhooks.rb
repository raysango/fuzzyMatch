class AddsInsuranceWebhooks < ActiveRecord::Migration[6.0]
  def up
    create_table :insurance_webhooks do |t|
      t.string :status
      t.jsonb :wh_data
      t.references :insurance, index: true
    end
    add_index(:insurance_webhooks, "(wh_data ->'Company'->'ID')", name: 'index_insurance_webhooks_on_company_id')
  end

  def down
    drop_table :insurance_webhooks
    remove_index :index_insurance_webhooks_on_company_id
  end
end
