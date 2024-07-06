class Reference < ApplicationRecord
  belongs_to :referencable, polymorphic: true
end
