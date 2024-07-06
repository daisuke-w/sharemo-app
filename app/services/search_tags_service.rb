class SearchTagsService
  def self.search(keyword)
    return [] if keyword.blank?

    tags = Tag.where('name LIKE ?', "#{keyword}%")
    tags.map { |tag| { id: tag.id, name: tag.name } }
  end
end
