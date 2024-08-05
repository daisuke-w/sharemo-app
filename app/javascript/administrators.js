/**
 * アコーディオン初期化
 * クリックイベントを追加し、コンテンツを表示
 */
function initializeAccordion() {
  const accordionButtons = document.querySelectorAll('.accordion-button');

  accordionButtons.forEach(button => {
    button.addEventListener('click', function() {
      const userId = this.getAttribute('data-user-id');
      const content = document.getElementById(`accordion-${userId}`);
      content.style.display = content.style.display === 'table-row' ? 'none' : 'table-row';
      this.classList.toggle('active');
    });
  });
};

/**
 * 所有者を変更する関数
 */
function initializeChangeOwner() {
  const changeOwnerButtons = document.querySelectorAll('.change-owner');

  changeOwnerButtons.forEach(button => {
    button.addEventListener('click', function() {
      const userId = this.getAttribute('data-user-id');
      const newOwnerId = document.getElementById(`owner-select-${userId}`).value;

      if (newOwnerId === "") {
        alert('変更先を選択してください');
        return;
      }

      const XHR = new XMLHttpRequest();
      XHR.open('PATCH', `/administrators/${userId}/update_owner`, true);
      XHR.setRequestHeader('Content-Type', 'application/json');
      XHR.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').getAttribute('content'));

      XHR.onreadystatechange = function() {
        if (XHR.readyState === XMLHttpRequest.DONE) {
          if (XHR.status === 200) {
            // JSONレスポンスをパースして処理
            const response = JSON.parse(XHR.responseText);
            if (response.status === 'success') {
              // 成功時の処理
              alert('所有者が変更されました');
              window.location.reload(); // 成功後にページをリロード
            } else {
              alert('所有者の変更に失敗しました');
            }
          } else {
            // エラー時の処理
            alert('所有者の変更に失敗しました');
          }
        }
      };

      XHR.send(JSON.stringify({ user_id: userId, new_owner_id: newOwnerId }));
    });
  });
};

document.addEventListener('turbo:load', function() {
  initializeAccordion();
  initializeChangeOwner();
});

document.addEventListener('turbo:render', function() {
  initializeAccordion();
  initializeChangeOwner();
});
