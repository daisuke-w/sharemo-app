/**
 * コードブロックの内容をコピーする関数
 */
function copy() {
  const buttons = document.querySelectorAll('.copy-button');
  
  buttons.forEach(button => {
    button.addEventListener('click', function() {
      // クリックしたボタンに紐づくコードの範囲の定義
      const code = this.closest('.highlight-wrap').querySelector('.rouge-code');
      
      // クリップボードにコードをコピーしてから、ボタンのテキストを変更する
      navigator.clipboard.writeText(code.innerText)
        .then(() => {
          this.innerText = 'Copied';
          
          // 3秒後に 'Copy' に戻す
          setTimeout(() => {
            this.innerText = 'Copy';
          }, 3000);
        });

      // コピーしたコードが選択されたようにする 
      window.getSelection().selectAllChildren(code);
    });
  });
};

document.addEventListener('turbo:load', function() {
  copy();
});

document.addEventListener('turbo:render', function() {
  copy();
});
