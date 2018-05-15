# This will guess the User class
FactoryBot.define do
  factory :normal_one, class: Member do
    email     "concepcion@runolfon.co"
    password  "12345678"
  end
  factory :another_one, class: Member do
    email     "ruthie@strosinthompson.com"
    password  "12345678"
  end
  factory :admin, class: Member do
    email     "admin@gmail.com"
    password  "12345678"
    admin     true
  end
  factory :unauthorized, class: Member do
    email     "goodshit@gmail.com"
    password  "donttellanyone"
  end
end
