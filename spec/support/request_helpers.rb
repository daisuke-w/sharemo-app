module RequestHelpers
  # ログインページにリダイレクト
  def expect_redirect_to_login(http_method, path)
    public_send(http_method, path)
    expect(response).to redirect_to(new_user_session_path)
  end

  # 一覧ページにリダイレクト
  def expect_redirect_to_list(http_method, path)
    public_send(http_method, path)
    expect(response).to redirect_to(notes_path)
  end

  # 正常なレスポンスを返却
  def expect_successful_response(http_method, path, params: {})
    public_send(http_method, path, params:)
    expect(response.status).to eq(200)
  end

  # レスポンスに含まれるかを確認
  def expect_element_in_response(http_method, path, element, params: {})
    public_send(http_method, path, params:)
    expect(response.body).to include(element)
  end

  # レスポンスに含まれていないかを確認
  def expect_element_not_in_response(http_method, path, element, params: {})
    public_send(http_method, path, params:)
    expect(response.body).not_to include(element)
  end

  # クリック数増減
  def increment_clicks(reference, is_filled)
    type = reference.class.name.downcase
    post public_send("increment_clicks_#{type}_reference_path", reference), params: {
      "#{type}_id": reference.id,
      is_filled:
    }
  end

  # 増減したクリック数の確認
  def expect_click_count(reference, expected_count)
    expect(reference.reload.click_count).to eq(expected_count)
    expect(JSON.parse(response.body)['click_count']).to eq(expected_count)
  end
end
