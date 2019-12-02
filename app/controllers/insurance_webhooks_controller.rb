class InsuranceWebhooksController < ApplicationController
  skip_before_action  :verify_authenticity_token

  def create
    matching_insurance = Insurance.get_insurance(params['Plan']['Name']) || InsuranceMatch.get_match(params['Plan']['Name'])
    if matching_insurance.present?
      InsuranceWebhook.create(status: 'matched', wh_data: params, insurance_id: matching_insurance.insurance_id)
    else
      InsuranceWebhook.create(status: 'pending', wh_data: params)
    end
  end

  def index
    @webhook_matches = InsuranceWebhook.get_pending_whs_with_matches
  end

  def match
    @whs = params[:insurance_whs] || {}
    errors = []
    errors << "No matches were submitted" unless @whs.present?
    @whs.each do |wh_id, insurance_id|
      wh = InsuranceWebhook.find(wh_id)
      if wh.update_attributes(insurance_id: insurance_id, status: 'matched')
        create_match(wh)
      else
        errors << wh.errors.full_messages
      end
    end
    if errors.present?
      flash[:error] = "Error while matching, #{errors.flatten.join(',')}"
    else
      flash[:notice] = 'Insurance Matches created'
    end
    redirect_to insurance_webhooks_path
  end

  private

  def create_match(wh)
    InsuranceMatch.first_or_create(name: wh.wh_data["Plan"]["Name"], insurance_id: wh.insurance_id)
  end

end
