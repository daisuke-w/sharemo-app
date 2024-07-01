/**
 * IDが'markdown-editor'の要素に対して
 * EasyMDE（Markdownエディタ）を初期化する関数
 */
function initializeEasyMDE() {
  const markdownEditor = document.getElementById('markdown-editor');
  if (markdownEditor) {
    const easyMDE = new EasyMDE({
      element: markdownEditor,
      placeholder: "Markdown記法が使えます...",
      toolbar: ["bold", "italic", "heading", "|", "quote", "unordered-list", "ordered-list", "|", "link", "image", "|", "preview", "guide"],
      renderingConfig: {
        codeSyntaxHighlighting: true
      }
    });
  }
};

window.addEventListener('turbo:load', initializeEasyMDE);
