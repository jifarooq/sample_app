namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do 
		User.create!(name: "Example User",
					 email: "user@maxpeel.com",
					 password: "foobar",
					 password_confirmation: "foobar")
		admin.toggle!(:admin)
		49.times do |n|
			name = Faker::Name.name
			email = "user_#{n+1}@maxpeel.com"
			password = "password"
			User.create!(name: name,
					 email: email,
					 password: "foobar",
					 password_confirmation: "foobar")
		end
	end
end