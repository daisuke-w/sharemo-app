require 'rouge/plugins/redcarpet'

class CustomRenderHTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  # Rouge::Plugins::Redcarpetのメソッドを上書き
  # コードブロックを検出
  def block_code(code, language)
    # 指定した言語のレキサー（構文解析器）を取得
    lexer = Rouge::Lexer.find_fancy(language, code) || Rouge::Lexers::PlainText
    # lexer.tag が 'make' である場合、先頭スペース4つで始まる行をタブ文字に置換
    code.gsub!(/^    /, "\t") if lexer.tag == 'make'
    formatter = rouge_formatter(lexer)
    # コードブロックに色つけ
    result = formatter.format(lexer.lex(code))

    if language.blank?
      "<div class=#{wrap_class}>#{copy_button}#{result}</div>"
    else
      compose_filename_and_language(result, language)
    end
  end

  # フォーマットを設定
  def rouge_formatter(_options = {})
    options = {
      css_class: 'highlight',
      line_numbers: true,
      line_format: '<span>%i</span>'
    }
    Rouge::Formatters::HTMLLegacy.new(options)
  end

  private

  # wrap CSSクラス名の定義
  def wrap_class
    'highlight-wrap'
  end

  # header CSSクラス名の定義
  def header_class
    'code-header'
  end

  # code CSSクラス名の定義
  def code_class
    'code-box'
  end

  # コピーボタンの定義
  # クリックするとmarkdown_output.jsの関数を実行
  def copy_button
    "<button class='copy-button'>Copy</button>"
  end

  # コードブロックの言語、コピーボタンを設置(htmlタグ作成)
  def compose_filename_and_language(result, language)
    info_section = "<span class='highlight-info'>#{language}</span>"

    %(<div class=#{wrap_class}>
        <div class=#{header_class}>
          #{info_section}
          #{copy_button}
        </div>
        <div class=#{code_class}>
          #{result}
        </div>
      </div>)
  end
end
