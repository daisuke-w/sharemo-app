/**
 * アイコンにクリックイベントを追加する関数
 */
function addClickEventListeners() {
  document.querySelectorAll('.icon-informative').forEach(icon => {
    icon.addEventListener('click', handleClickOnce);
  });
};

/**
 * アイコンのクリック処理を一度だけ実行する関数
 */
function handleClickOnce() {
  // イベントリスナーを一時的に削除
  this.removeEventListener('click', handleClickOnce);

  const isFilled = this.classList.contains('bi-lightbulb-fill');
  const referenceId = this.closest('.informative').getAttribute('data-reference-id');
  const referenceType = this.closest('.informative').getAttribute('data-reference-type');
  const dataId = this.closest('.informative').getAttribute('data-id');

  // アイコンの状態に応じてクリック数を増減
  if (isFilled) {
    // アイコンが塗りつぶし状態の場合、クリック数を減らす
    incrementClicks(referenceId, referenceType, dataId, true);
    this.classList.remove('bi-lightbulb-fill');
    this.classList.add('bi-lightbulb');
  } else {
    // アイコンが通常状態の場合、クリック数を増やす
    incrementClicks(referenceId, referenceType, dataId, false);
    this.classList.remove('bi-lightbulb');
    this.classList.add('bi-lightbulb-fill');
  }

  // 一定時間後にイベントリスナーを再度追加(イベント重複発生回避の為)
  setTimeout(() => {
    this.addEventListener('click', handleClickOnce);
  }, 300);
};

/**
 * クリック数を更新する関数
 * @param {number} referenceId - 参考ID
 * @param {string} referenceType - Note or Prompt
 * @param {number} dataId - ノートID or プロンプトID
 * @param {boolean} isFilled - アイコンが塗りつぶし状態かどうか
 */
function incrementClicks(referenceId, referenceType, dataId, isFilled) {
  const XHR = new XMLHttpRequest();
  let url = ""
  if ("Note" === referenceType) {
    url = `/notes/${dataId}/reference/increment_clicks`
  } else {
    url = `/prompts/${dataId}/reference/increment_clicks`
  }
  XHR.open("POST", url, true);
  XHR.setRequestHeader("Content-Type", "application/json");
  XHR.setRequestHeader("X-CSRF-Token", getCSRFToken());

  XHR.responseType = "json";

  XHR.onload = () => {
    if (XHR.status >= 200 && XHR.status < 300) {
      const data = XHR.response;
      if (data.hasOwnProperty('click_count')) {
        // クリック数を更新
        const countElement = document.querySelector(`[data-reference-id='${referenceId}'] .informative-count`);
        if (countElement) {
          countElement.textContent = data.click_count;
        } else {
          console.error('Count element not found.');
        }
      } else {
        console.error('Error:', data.message);
      }
    } else {
      console.error('HTTP Error:', XHR.statusText);
    }
  };

  XHR.onerror = () => {
    console.error('Network error occurred.');
  };

  // POSTデータの準備
  const postData = { is_filled: isFilled };

  XHR.send(JSON.stringify(postData));
};

/**
 * CSRFトークンを取得する関数
 * @returns {string} - CSRFトークン
 */
function getCSRFToken() {
  return document.querySelector('[name=csrf-token]').content;
};

document.addEventListener('turbo:load', function() {
  addClickEventListeners();
});

document.addEventListener('turbo:render', function() {
  addClickEventListeners();
});
