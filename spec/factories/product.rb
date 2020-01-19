FactoryBot.define do
  factory :product do
    to_create do |instance|
      DB.save(instance)
      instance
    end
  end
end

