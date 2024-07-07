class SearchTagsService
  def self.search(keyword)
    return [] if keyword.blank?

    tags = Tag.where('tag_name LIKE ?', "#{keyword}%")
    tags.map { |tag| { id: tag.id, tag_name: tag.tag_name } }
  end
end
