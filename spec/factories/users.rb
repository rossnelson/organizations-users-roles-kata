FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(10) }

    transient do
      role_count 3
    end

    trait :with_roles_and_orgs do
      after(:create) do |user, evaluator|
        create(:root_org, :with_descendants)

        ids = Org.ids.shuffle
        create(:role, name: "Admin", user: user, org_id: ids.pop)
        create(:role, name: "User", user: user, org_id: ids.pop)
        create(:role, name: "Denied", user: user, org_id: ids.pop)
      end
    end

  end
end
