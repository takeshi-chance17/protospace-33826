require 'rails_helper'

RSpec.describe "Prototypes", type: :system do
  before do
    @prototype = FactoryBot.create(:prototype)
  end

  it "プロトタイプ投稿機能" do
    # サインインページへ移動する
    visit new_user_session_path
    # すでに保存されているユーザーの情報を入力する
    fill_in 'user_email', with: @prototype.user.email
    fill_in 'user_password', with: @prototype.user.password
    # ログインボタンをクリックする
    find('input[name="commit"]').click
    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path
    # ログイン中はログアウトボタンとNew Protoボタンがあることを確認する
    expect(page).to have_content("ログアウト")
    expect(page).to have_content("New Proto")
    # 現在の投稿数を把握しておく
    cnt = (Prototype.group(:id).count).count
    # 投稿ページに遷移する
    click_on("new_proto")
    expect(current_path).to eq new_prototype_path
    # 投稿する
    fill_in 'title_field', with: @prototype.title
    fill_in 'catch_copy_field', with: @prototype.catch_copy
    fill_in 'text_area_field', with: @prototype.concept
    attach_file 'image_field','public/images/sample1.png'
    click_on('save_btn')
    # 投稿後にトップページに遷移していること
    expect(current_path).to eq root_path
    # 投稿数が1増えている事を確認する(投稿した情報は、トップページに表示されること)
    expect(cnt + 1).to eq((Prototype.group(:id).count).count)
    # プロトタイプ毎に、画像・プロトタイプ名・キャッチコピー・投稿者の名前の、4つの情報について表示できること
    expect(Prototype.group(:id)[cnt].title).to eq @prototype.title
    expect(Prototype.group(:id)[cnt].catch_copy).to eq @prototype.catch_copy
    expect(Prototype.group(:id)[cnt].concept).to eq @prototype.concept
    binding.pry
    expect(Prototype.group(:name)[cnt].name).to eq @prototype.name
    # 画像が表示されており、画像がリンク切れなどになっていないこと
    expect(page).to have_selector @prototype.image
    
  end
end
