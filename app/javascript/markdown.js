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

/**
 * トグルボタンの変更イベントを監視し、
 * ラベルのデータ状態を更新する関数
 */
function updateToggleStatus() {
  const toggleInputs = document.querySelectorAll('.toggle-status');

  toggleInputs.forEach(function(input) {
    input.addEventListener('change', function() {
      const label = input.nextElementSibling;
      label.dataset.state = input.checked ? 'on' : 'off';
    });
  });
};

window.addEventListener('turbo:load', function() {
  initializeEasyMDE();
  updateToggleStatus();
}); 