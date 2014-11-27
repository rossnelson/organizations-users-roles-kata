FactoryGirl.define do
  factory :org do
    name Faker::Company.name
  end

  factory :root_org, class: RootOrg do
    name Faker::Company.name
  end

  factory :organization, class: Organization do
    name Faker::Company.name
  end

  factory :child_org, class: ChildOrg do
    name Faker::Company.name
  end

  # => Orgs with associations
  factory :organization_with_root, class: Organization do
    name Faker::Company.name
    association :root_org, factory: :root_org
  end

  factory :organization_with_children, class: Organization do
    name Faker::Company.name
    association :root_org, factory: :root_org

    transient do
      child_count 5
    end

    after(:build) do |org, evaluator|
      create_list(:child_org, evaluator.child_count, organization: org)
    end
  end

  factory :root_org_with_orgs, class: RootOrg do
    name Faker::Company.name

    transient do
      child_count 2
    end

    after(:build) do |org, evaluator|
      create_list(:organization_with_children, evaluator.child_count, root_org: org)
    end
  end


end
