class UserInfoService
  # ユーザーに関する情報を提供するサービス
  def initialize(user)
    @user = user
  end

  # ユーザーの情報を取得
  def user_information
    {
      note_information:,    # ノートに関する情報
      prompt_information:,  # プロンプトに関する情報
      public_notes:,        # ユーザーの保有する公開ノート一覧
      private_notes:,       # ユーザーの保有する非公開ノート一覧
      public_prompts:,      # ユーザーの保有する公開プロンプト一覧
      private_prompts:,     # ユーザーの保有する非公開プロンプト一覧
      notes_by_category:,   # カテゴリ別ノート一覧
      prompts_by_category:  # カテゴリ別プロンプト一覧
    }
  end

  private

  # ノートに関する情報を取得
  def note_information
    {
      total: total_notes_count,
      public: public_notes_count,
      private: private_notes_count,
      total_reference_clicks: total_note_reference_clicks
    }
  end

  # プロンプトに関する情報を取得
  def prompt_information
    {
      total: total_prompts_count,
      public: public_prompts_count,
      private: private_prompts_count,
      total_reference_clicks: total_prompt_reference_clicks
    }
  end

  # ユーザーの公開ノートを取得
  def public_notes
    @user.notes.where(is_public: true).order(Arel.sql('GREATEST(created_at, updated_at) DESC'))
  end

  # ユーザーの非公開ノートを取得
  def private_notes
    @user.notes.where(is_public: false).order(Arel.sql('GREATEST(created_at, updated_at) DESC'))
  end

  # ユーザーの公開プロンプトを取得
  def public_prompts
    @user.prompts.where(is_public: true).order(Arel.sql('GREATEST(created_at, updated_at) DESC'))
  end

  # ユーザーの非公開プロンプトを取得
  def private_prompts
    @user.prompts.where(is_public: false).order(Arel.sql('GREATEST(created_at, updated_at) DESC'))
  end

  # カテゴリ別にユーザーのノートをグループ化して取得
  def notes_by_category
    @user.notes.group_by(&:category).sort_by { |category, _notes| category.id }
  end

  # カテゴリ別にユーザーのプロンプトをグループ化して取得
  def prompts_by_category
    @user.prompts.group_by(&:category).sort_by { |category, _notes| category.id }
  end

  # ユーザーの全ノート数を取得
  def total_notes_count
    @user.notes.count
  end

  # ユーザーの公開ノート数を取得
  def public_notes_count
    @user.notes.where(is_public: true).count
  end

  # ユーザーの非公開ノート数を取得
  def private_notes_count
    @user.notes.where(is_public: false).count
  end

  # ユーザーの全ノートの参考クリック数の合計を取得
  def total_note_reference_clicks
    @user.notes.sum { |note| note.reference.click_count }
  end

  # ユーザーの全プロンプト数を取得
  def total_prompts_count
    @user.prompts.count
  end

  # ユーザーの公開プロンプト数を取得
  def public_prompts_count
    @user.prompts.where(is_public: true).count
  end

  # ユーザーの非公開プロンプト数を取得
  def private_prompts_count
    @user.prompts.where(is_public: false).count
  end

  # ユーザーの全プロンプトの参考クリック数の合計を取得
  def total_prompt_reference_clicks
    @user.prompts.sum { |prompt| prompt.reference.click_count }
  end
end
