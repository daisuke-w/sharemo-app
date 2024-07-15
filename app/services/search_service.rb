class SearchService
  def initialize(current_user)
    @current_user = current_user
  end

  def self.search_tags(keyword)
    return [] if keyword.blank?

    tags = Tag.where('tag_name LIKE ?', "#{keyword}%")
    tags.map { |tag| { id: tag.id, tag_name: tag.tag_name } }
  end

  def search_notes_and_prompts(params)
    keyword = params[:keyword]
    category = params[:category]
    tags = params[:tags]
    type = params[:type]
    sort = params[:sort]

    notes = Note.includes(:user, :prompt, :tags, :reference)
                .where(group_id: @current_user.group_id)
    prompts = Prompt.includes(:user, :notes, :tags, :reference)
                    .where(group_id: @current_user.group_id)

    notes, prompts = filter_by_keyword(notes, prompts, keyword)
    notes, prompts = filter_by_category(notes, prompts, category)
    notes, prompts = filter_by_tags(notes, prompts, tags)
    notes, prompts = filter_by_type(notes, prompts, type)
    notes, prompts = order_results(notes, prompts, sort)

    { notes:, prompts: }
  end

  # キーワードで検索する
  def filter_by_keyword(notes, prompts, keyword)
    if keyword.present?
      notes = notes.where('title LIKE ? OR content LIKE ?', "%#{keyword}%", "%#{keyword}%")
      prompts = prompts.where('title LIKE ? OR content LIKE ?', "%#{keyword}%", "%#{keyword}%")
    end
    [notes, prompts]
  end

  # カテゴリーでフィルタリングする
  def filter_by_category(notes, prompts, category)
    if category.present?
      notes = notes.where(category_id: category)
      prompts = prompts.where(category_id: category)
    end
    [notes, prompts]
  end

  # タグでフィルタリングする
  def filter_by_tags(notes, prompts, tags)
    if tags.present?
      note_tag_ids = NoteTag.where(tag_id: tags).pluck(:note_id)
      prompt_tag_ids = PromptTag.where(tag_id: tags).pluck(:prompt_id)
      notes = notes.where(id: note_tag_ids)
      prompts = prompts.where(id: prompt_tag_ids)
    end
    [notes, prompts]
  end

  # タイプでフィルタリングする
  def filter_by_type(notes, prompts, type)
    if type.present?
      case type
      when 'Note'
        prompts = Prompt.none
      when 'Prompt'
        notes = Note.none
      end
    end
    [notes, prompts]
  end

  # 結果を並べ替える
  def order_results(notes, prompts, sort)
    if sort.present?
      case sort
      when 'created_desc'
        notes = notes.order(created_at: :desc)
        prompts = prompts.order(created_at: :desc)
      when 'created_asc'
        notes = notes.order(created_at: :asc)
        prompts = prompts.order(created_at: :asc)
      when 'reference_count_desc'
        notes = notes.left_joins(:reference).order('references.click_count DESC')
        prompts = prompts.left_joins(:reference).order('references.click_count DESC')
      end
    end
    [notes, prompts]
  end
end
