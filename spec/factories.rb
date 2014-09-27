FactoryGirl.define do
  factory :user do
    name "Justin"
    email "jif@blah.com"
    password "good_pw"
    password_confirmation "good_pw"
  end
end
