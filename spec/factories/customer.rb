FactoryBot.define do
  factory :customer do
    to_create do |instance|
      DB.save(instance)
      instance
    end
  end
end
