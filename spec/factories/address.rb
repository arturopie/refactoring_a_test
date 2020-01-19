FactoryBot.define do
  factory :address do
    to_create do |instance|
      DB.save(instance)
      instance
    end
  end
end

