module CommonMethods
  extend ActiveSupport::Concern

  # is_publicカラムが1の場合に true を返す
  def public?
    is_public
  end
end
