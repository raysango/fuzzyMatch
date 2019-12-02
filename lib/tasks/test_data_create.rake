namespace :test_data do
  task create: :environment do
    INSURANCE_PLANS = ['AET Gold', 'AET Amber', 'AET Essential', 'Blue Cross Global', 'Blue Cross 365', 'Humana Preventive', 'Humana Loyalty Plaus']
    WH_PLAN_NAMES = ['Aetna gold', 'Atna aber', 'Vlue croos 365']
    WH_PLAN = {'ID' => '12345','IDType' => 'Payor ID','Name' => 'Deductable Plan','Type' => nil}
    WH_OBJECT = {'MemberNumber' => nil,'Company' => {'ID' => '54321','IDType' => nil,'Name' => 'roundtrip (123 456)','Address' => {'StreetAddress' => 'PO Box 12345','City' => 'Roundtrip Town','State' => 'RT','ZIP' => '12345','County' => 'Health County','Country' => 'US'},'PhoneNumber' => '+12223334444'},'GroupNumber' => '847025-123-4567','GroupName' => 'The Core Team','EffectiveDate' => '2015-01-01','ExpirationDate' => '2020-12-31','PolicyNumber' => '656835555','AgreementType' => nil,'CoverageType' => nil,'Insured' => {'Identifiers' => [],'LastName' => nil,'FirstName' => nil,'SSN' => nil,'Relationship' => nil,'DOB' => nil,'Sex' => nil,'Address' => {'StreetAddress' => nil,'City' => nil,'State' => nil,'ZIP' => nil,'County' => nil,'Country' => nil}}}
    INSURANCE_PLANS.map{|plan| Insurance.create(name: plan)}
    WH_PLAN_NAMES.map{|wh_plan| InsuranceWebhook.create(status: 'pending', wh_data: WH_OBJECT.merge!('Plan' => WH_PLAN.merge!('Name' => wh_plan)))}
  end
end
  
