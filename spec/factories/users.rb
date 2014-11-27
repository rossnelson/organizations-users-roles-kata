FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password(10)

    transient do
      role_count 3
    end

    trait :with_roles_and_orgs do
      after(:create) do |user, evaluator|
        create(:root_org_with_orgs)

        evaluator.role_count.times do 
        user.roles.create!(
          name: Role.name_options.sample, 
          org: Org.all.sample
        )
        end
      end
    end

  end
end
