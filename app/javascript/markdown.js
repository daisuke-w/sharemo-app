/**
 * IDが'markdown-editor'の要素に対して
 * EasyMDE（Markdownエディタ）を初期化する関数
 */
function initializeEasyMDE() {
  const markdownEditor = document.getElementById('markdown-editor');
  if (markdownEditor && !markdownEditor.hasAttribute('data-easymde-initialized')) {
    const easyMDE = new EasyMDE({
      element: markdownEditor,
      placeholder: "Markdown記法が使えます...",
      toolbar: ["bold", "italic", "heading", "|", "quote", "unordered-list", "ordered-list", "|", "link", "image", "|", "preview", "guide"],
      renderingConfig: {
        codeSyntaxHighlighting: true
      }
    });
    markdownEditor.setAttribute('data-easymde-initialized', 'true');
  }
};

/**
 * トグルボタンの変更イベントを監視し、
 * ラベルのデータ状態を更新する関数
 */
function updateToggleStatus() {
  const toggleInputs = document.querySelectorAll('.toggle-status');
  if (toggleInputs) {
    toggleInputs.forEach(function(input) {
      // ページロード時に初期状態を設定
      const label = input.nextElementSibling;
      label.dataset.state = input.checked ? 'on' : 'off';

      // 状態が変更されたときにラベルを更新
      input.addEventListener('change', function() {
        label.dataset.state = input.checked ? 'on' : 'off';
      });
    });
  }
};

document.addEventListener('turbo:load', function() {
  initializeEasyMDE();
  updateToggleStatus();
});

document.addEventListener('turbo:render', function() {
  initializeEasyMDE();
  updateToggleStatus();
});
