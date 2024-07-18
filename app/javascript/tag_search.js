/**
 * タグ入力を処理する関数
 */
function handleTagInput() {
  const inputElement = document.querySelector(".custom-input-tag");
  const searchResult = document.getElementById("search-result");

  if (inputElement) {
    inputElement.addEventListener("input", () => {
      const currentTags = inputElement.value.split(",").map(tag => tag.trim());
      const keyword = currentTags.pop();

      if (keyword.length > 0) {
        const XHR = new XMLHttpRequest();
        XHR.open("GET", `/searches/tags?keyword=${keyword}`, true);
        XHR.responseType = "json";
        XHR.send();

        XHR.onload = () => {
          searchResult.innerHTML = "";

          if (XHR.response) {
            const tags = XHR.response.keyword;

            tags.forEach((tag) => {
              const childElement = document.createElement("div");
              childElement.classList.add("child");
              childElement.textContent = tag.tag_name;
              searchResult.appendChild(childElement);

              // 入力候補のタグがクリックされた時の動作を設定
              childElement.addEventListener("click", () => {
                currentTags.push(tag.tag_name);
                inputElement.value = currentTags.join(", ") + ", ";
                searchResult.innerHTML = ""; // 選択後に検索結果をクリア
                inputElement.focus();
              });
            });
          }
        };
      } else {
        searchResult.innerHTML = "";
      }
    });

    // Enter キーによるフォームの送信を防止
    inputElement.addEventListener("keydown", (event) => {
      if (event.key === "Enter") {
        event.preventDefault();
      }
    });
  }
}

/**
 * 検索フォームにselect2を実装
 * 初期化する関数
 */
function initializeSelect2() {
  $('.select2').select2({
    placeholder: "タグを選択",
    allowClear: true,
    width: '100%'
  });
};

document.addEventListener('turbo:load', function() {
  handleTagInput();
  initializeSelect2();
});

document.addEventListener('turbo:render', function() {
  handleTagInput();
  initializeSelect2();
});
