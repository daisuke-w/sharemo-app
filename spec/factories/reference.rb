FactoryBot.define do
  factory :reference do
    transient do
      referencable { nil }
    end

    after(:build) do |reference, evaluator|
      reference.referencable = evaluator.referencable
    end
  end
end