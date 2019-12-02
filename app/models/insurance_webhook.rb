class InsuranceWebhook < ActiveRecord::Base
  validates :status, inclusion: { in: ['pending', 'matched'] }
  MATCH_RATE = 0.2.freeze
  class << self
    def get_pending_whs_with_matches
          select("insurance_webhooks.id as webhook_id, insurances.name as insurance_name, insurances.id as insurance_id, insurance_webhooks.wh_data -> 'Plan' ->> 'Name' as plan_name")
          .where("(insurance_webhooks.status = 'pending') AND (insurance_webhooks.insurance_id IS NULL)")
          .joins("LEFT JOIN insurances ON similarity(insurances.name, insurance_webhooks.wh_data -> 'Plan' ->> 'Name') > #{MATCH_RATE}").order('plan_name')
      .group_by{|match| match.webhook_id}
    end
  end
end