FactoryBot.define do
  factory :shortened_url do
    url { "MyText" }
    url_key { "MyString" }
    click_count { 1 }
    user { nil }
  end
end
