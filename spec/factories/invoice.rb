FactoryBot.define do
  factory :invoice do
    initialize_with do
      new(attributes)
    end

    to_create do |instance|
      DB.save(instance)
      instance
    end
  end
end
