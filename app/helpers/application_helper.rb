require 'custom_render_html'

module ApplicationHelper
  def markdown(text)
    options = {
      filter_html: true,                                     # HTMLタグをフィルタリング
      with_toc_data: true,                                   # 見出しにアンカーリンクを追加し、目次を生成できるようにする
      hard_wrap: true,                                       # 改行を <br> タグに変換し、テキストの改行を保持する
      link_attributes: { rel: 'nofollow', target: '_blank' } # リンクに属性を追加
    }

    extensions = {
      no_intra_emphasis: true,                               # 単語内の強調を無効にする（例：foo_bar_baz は <em>foo_bar_baz</em> にならない）
      tables: true,                                          # テーブルをサポートする
      fenced_code_blocks: true,                              # フェンス付きコードブロック（```で囲まれたコードブロック）をサポートする
      autolink: true,                                        # 自動リンクを有効にする（URLやメールアドレスをリンクに変換する）
      superscript: true,                                     # 上付き文字をサポート（例: x²）
      lax_spacing: true,                                     # 緩やかなスペーシングを許可する（パラグラフ間の空行が1行でも認識される）
      lax_html_blocks: true,                                 # HTMLブロックの緩やかなパースを許可する
      footnotes: true,                                       # 脚注をサポートする
      space_after_headers: true,                             # 見出しの後にスペースを必要とする（例：`# 見出し` の形式）
      strikethrough: true,                                   # 打ち消し線をサポートする（例：~~打ち消し~~）
      underline: true,                                       # 下線をサポートする（例：<u>下線</u>）
      highlight: true,                                       # ==で囲まれたテキストをハイライトする（例：==ハイライト==）
      quote: true                                            # 引用をサポートする（例：> 引用）
    }

    renderer = CustomRenderHTML.new(options)
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
                  raise 'Unknown object type'
                end

    if [:show, :destroy].include?(action)
      send("#{base_path}_path", object)
    else
      send("#{action}_#{base_path}_path", object)
    end
  end
end
