Using rails 6.0.1 and ruby 2.6.3p62

fuzzyMatch is a small tool that accepts custom insurance objects and creates a matching list of clean insurance data.

insurance object example:

      {
        'Plan' => {
          'ID' => '12345',
          'IDType' => 'Payor ID',
          'Name' => 'Deductable Plan',
          'Type' => nil
        },
        'MemberNumber' => nil,
        'Company' => {
          'ID' => '54321',
          'IDType' => nil,
          'Name' => 'roundtrip (123 456)',
          'Address' => {
            'StreetAddress' => 'PO Box 12345',
            'City' => 'Roundtrip Town',
            'State' => 'RT',
            'ZIP' => '12345',
            'County' => 'Health County',
            'Country' => 'US'
          },
          'PhoneNumber' => '+12223334444'
        },
        'GroupNumber' => '847025-123-4567',
        'GroupName' => 'The Core Team',
        'EffectiveDate' => '2015-01-01',
        'ExpirationDate' => '2020-12-31',
        'PolicyNumber' => '656835555',
        'AgreementType' => nil,
        'CoverageType' => nil,
        'Insured' => {
          'Identifiers' => [],
          'LastName' => nil,
          'FirstName' => nil,
          'SSN' => nil,
          'Relationship' => nil,
          'DOB' => nil,
          'Sex' => nil,
          'Address' => {
            'StreetAddress' => nil,
            'City' => nil,
            'State' => nil,
            'ZIP' => nil,
            'County' => nil,
            'Country' => nil
          }
        }
      }
   
   Using Trigram to identify the matching insurance objects towards the incoming insurance webhooks.
   
   A similarity threshold score of 0.2 is being used here, can be changed if needed (constant MATCH_RATE)
   
   Insurance webhooks will be received on: /insurance_webhooks action_type: POST
   Once received:
   
   - An exact match will be executed against clean insurance objects in insurances table and against insurance_matches table which will contain all previously matched objects by internal users, if an exact match were found then the webhook will be stored with status 'matched'.
   
   - If no exact match found then the webhook will be stored with status 'pending'.
   
   - A list of pending webhooks with no insurance match will be represented on /insurance_webhooks action_type: GET with matching insurance objects with the option to assign an insurance object to each webhook if matching objects were found.


Load test data: bundle exec rake test_data:create

Things that can be added:

- Add the option to create an insurance object if no match was found for a webhook.
- Add pagination to /insurance_webhooks to accommodate large numbers of un matched webhooks.
