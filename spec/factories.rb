FactoryGirl.define do
  factory :user do
  	sequence(:name)  { |n| "Person #{n}" }
  	sequence(:email) { |n| "person#{n}@maxpeel.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin	do
    	admin true
    end
  end

  factory :micropost do
  	content "Carpe the diem!"
  	user
  end
  
end
