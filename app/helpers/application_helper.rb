# app/helpers/application_helper.rb
module ApplicationHelper
  def markdown(text)
    options = {
      filter_html: true,                    # HTMLタグをフィルタリング
      hard_wrap: true,                      # 改行を保持
      link_attributes: { rel: 'nofollow', target: '_blank' }, # リンクに属性を追加
      space_after_headers: true,            # ヘッダの後にスペースを追加
      fenced_code_blocks: true              # コードブロックをサポート
    }

    extensions = {
      autolink: true,                       # 自動でリンクを生成（URLやメールアドレスをリンクに変換）
      superscript: true,                    # 上付き文字をサポート（例: x²）
      disable_indented_code_blocks: true    # インデントによるコードブロックを無効化
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end

  def dynamic_path(object, action)
    base_path = case object
                when Note
                  'note'
                when Prompt
                  'prompt'
                else
                  raise "Unknown object type"
                end

    if (action == :show || action == :destroy)
      send("#{base_path}_path", object)
    else
      send("#{action}_#{base_path}_path", object)
    end
  end
end
