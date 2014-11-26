FactoryGirl.define do
  factory :org do
    name Faker::Company.name
  end

  factory :root_org, class: Org::Root do
    name Faker::Company.name
  end

  factory :child_org, class: Org::Child do
    name Faker::Company.name
  end

end
