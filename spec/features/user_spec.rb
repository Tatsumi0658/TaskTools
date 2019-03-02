require 'rails_helper'

RSpec.feature "ユーザー登録関連機能", type: :feature do
  scenario "ユーザー登録テスト" do
    visit new_user_path
    fill_in "名前", with: "sample"
    fill_in "メールアドレス", with:"sample@sample.com"
    fill_in "パスワード", with: "password"
    fill_in "もう一度入力してください", with:"password"
    click_on "登録する"

    expect(page).to have_content "タスク一覧"
  end

  before do
    User.create!(name: "test", email: "test@test.com", password: "testtest")
  end

  scenario "ログイン" do
    visit new_session_path
    fill_in "メールアドレス", with:"test@test.com"
    fill_in "パスワード", with:"testtest"
    click_button "Login"

    expect(page).to have_content "タスク作成"
  end

  scenario "ログアウト" do
    visit new_session_path
    fill_in "メールアドレス", with:"test@test.com"
    fill_in "パスワード", with:"testtest"
    click_button "Login"

    click_on "Logout"
    expect(page).to have_content "Login"
  end

end
