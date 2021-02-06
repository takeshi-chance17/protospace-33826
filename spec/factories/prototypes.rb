FactoryBot.define do
  factory :prototype do
    title             {Faker::Lorem.sentence}
    catch_copy        {Faker::Lorem.sentence}
    concept           {Faker::Lorem.sentence}

    association       :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/sample1.png'), filename: 'sample1.png')
    end
  end
end
