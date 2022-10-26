FactoryBot.define do
  factory :match_batch_import do
    status { :pending }

    trait :with_attachment do
      after(:build) do |match_batch_import|
        match_batch_import.csv.attach(
          io: Rails.root.join('spec/fixtures/files/matches_01.csv').open,
          filename: 'matches_01.csv',
          content_type: 'text/csv'
        )
      end
    end
  end
end
