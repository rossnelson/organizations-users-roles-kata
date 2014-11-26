FactoryGirl.define do
  factory :user do
    email "axcess1@me.com"
    password "wibble"
    crypted_password ""
    salt ""
  end

end
