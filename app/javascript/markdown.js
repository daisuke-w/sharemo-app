/**
 * IDが'markdown-editor'の要素に対して
 * EasyMDE（Markdownエディタ）を初期化する関数
 */
function initializeEasyMDE() {
  const easyMDE = new EasyMDE({
    element: document.getElementById('markdown-editor'),
    placeholder: "Markdown記法が使えます...",
    // ツールバーに表示する項目を設定
    toolbar: ["bold", "italic", "heading", "|", "quote", "unordered-list", "ordered-list", "|", "link", "image", "|", "preview", "guide"],
    // シンタックスハイライトの適応
    renderingConfig: {
      codeSyntaxHighlighting: true
    }
  });
}

window.addEventListener('turbo:load', initializeEasyMDE);
window.addEventListener('turbo:render', initializeEasyMDE);
