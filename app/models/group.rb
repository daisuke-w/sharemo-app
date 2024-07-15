class Group < ActiveHash::Base
  self.data = YAML.load_file(Rails.root.join('config', 'groups.yml'))

  include ActiveHash::Associations
  has_many :users
  has_many :notes
  has_many :prompts
end
