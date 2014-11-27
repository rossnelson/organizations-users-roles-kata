FactoryGirl.define do
  factory :role do
    user_id 1
    org_id 1

    trait(:admin) { name "Admin" }
    trait(:user) { name "User" }
    trait(:denied) { name "Denied" }
  end

end
