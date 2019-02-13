FactoryBot.define do
  factory :account_data, class: 'AccountData' do
    category_id "101"
    genre_id "10101"
    amount "1000"
    date "Date.today.to_s"
    comment "test comment"
    name "test"
    place "test place"
  end
end
