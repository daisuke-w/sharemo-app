class Reference < ApplicationRecord
  belongs_to :referencable, polymorphic: true

  with_options presence: true do
    validates :referencable_id
    validates :referencable_type
  end
end
