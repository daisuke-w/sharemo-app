module CommonMethods
  extend ActiveSupport::Concern

  # is_publicカラムが1の場合に true を返す
  def public?
    is_public
  end

  # 作成日 or 更新日から何日経過したかを返す
  def days_since_last_update
    latest_date = [created_at, updated_at].max
    (Date.today - latest_date.to_date).to_i
  end
end
