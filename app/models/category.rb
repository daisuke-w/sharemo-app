class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'プログラミング' },
    { id: 3, name: 'Web開発' },
    { id: 4, name: 'モバイル開発' },
    { id: 5, name: 'データベース' },
    { id: 6, name: 'クラウド' },
    { id: 7, name: 'ネットワーク' },
    { id: 8, name: 'AI' },
    { id: 9, name: 'データサイエンス' },
    { id: 10, name: 'セキュリティ' },
    { id: 11, name: 'IT業界' },
    { id: 12, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :notes
  has_many :prompts
end