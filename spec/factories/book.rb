# This will guess the User class
FactoryBot.define do
  factory :book_of_admin, class: Book do
    title     "Book of shit"
    author    "Jennifer Lau Rang"
  end
  factory :book_of_normal, class: Book do
    title     "Book of bull-pee"
    author    "Jennifer Lau Rang LAU LAU LAU"
  end
end
