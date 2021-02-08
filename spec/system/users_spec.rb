require 'rails_helper'

RSpec.describe "Users", type: :system do
  it "ログイン→ログアウトに成功する" do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # サインインページへ移動する
    visit root_path
    click_on("log_in")
    expect(current_path).to eq new_user_session_path
    # すでに保存されているユーザーの情報を入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンをクリックする
    find('input[name="commit"]').click
    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path
    # ログイン中はログアウトボタンとNew Protoボタンがあることを確認する
    expect(page).to have_content("ログアウト")
    expect(page).to have_content("New Proto")
    # ログイン中はこんにちは、〇〇さんがあることを確認する
    expect(page).to have_content("こんにちは、")  # こんにちはの検索
    find_by_id("hello_name")                    # 名前の表示位置のid検索
    # ログアウトする
    click_on("log_out")
    # ログアウト中はログインボタンがあることを確認する
    expect(page).to have_content("ログイン")
    expect(page).to have_content("新規登録")
  end
end
