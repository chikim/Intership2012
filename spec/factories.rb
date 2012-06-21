
FactoryGirl.define do
  factory :user do
    name     "Nobody"
    email    "nobody@nowhere.com"
    password "s3cr3t"
    password_confirmation "s3cr3t"
  end
end

