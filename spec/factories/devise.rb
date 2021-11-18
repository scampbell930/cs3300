FactoryBot.define do
    factory :user do
      id {1}
      email {"testemail@email.com"}
      password {"123456"}
      # Add additional fields as required via your User model
    end
end