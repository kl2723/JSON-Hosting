namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    User.create!(name: "Default",
                         email: "default@default.default",
                         password: "default",
                         password_confirmation: "default",
                         admin: false)

  end
end