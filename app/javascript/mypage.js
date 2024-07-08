/**
 * 指定されたURLからコンテンツを読み込む
 * @param {string} url - 読み込むコンテンツのURL
 */
function loadContent(url) {
  const xhr = new XMLHttpRequest();
  xhr.open('GET', url);
  xhr.setRequestHeader('Content-Type', 'text/html');
  xhr.onload = function() {
    if (xhr.status === 200) {
      document.querySelector('.mypage-main-content').innerHTML = xhr.responseText;
      window.location.hash = url.split('/').pop();
    }
  };
  xhr.send();
}

/**
 * サイドバーリンクを初期化
 * クリックイベントを追加し、コンテンツを読み込む
 */
function initializeSidebarLinks() {
  const links = document.querySelectorAll('.sidebar-link');
  links.forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      const url = this.href;
      loadContent(url);
    });
  });
}

document.addEventListener('turbo:load', function() {
  initializeSidebarLinks();
});

document.addEventListener('turbo:render', function() {
  initializeSidebarLinks();
});
