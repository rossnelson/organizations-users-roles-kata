FactoryGirl.define do
  factory :org do
    name { Faker::Company.name }
  end

  factory :root_org, class: RootOrg do
    name { Faker::Company.name }

    trait :with_descendants do
      transient do
        child_count 2
      end

      after(:build) do |org, evaluator|
        create_list(
          :organization_with_children, 
          evaluator.child_count, 
          root_org: org
        )
      end
    end
  end

  factory :organization, class: Organization do
    name { Faker::Company.name }

    trait :with_root do
      association :root_org, factory: :root_org
    end

    factory :organization_with_children do
      transient do
        child_count 5
      end

      after(:build) do |org, evaluator|
        create_list(:child_org, evaluator.child_count, organization: org)
      end
    end
  end

  factory :child_org, class: ChildOrg do
    name { Faker::Company.name }

    trait :with_organization do
      after(:create) do |child_org, evaluator|
        child_org.organization = create(:organization)
      end
    end
  end
end
