require 'rails_helper'

RSpec.feature "adminuser機能", type: :feature do
  before do
    User.create!(name: "aaa", email: "aaa@aaa.com", password: "aaaaaa", admin_flag: true)
    visit new_session_path
    fill_in "メールアドレス", with:"aaa@aaa.com"
    fill_in "パスワード", with:"aaaaaa"
    click_button "Login"
  end
  scenario "登録" do
    visit admin_users_path
    find(".btn-success").click
    fill_in "名前", with: "sample"
    fill_in "メールアドレス", with:"sample@sample.com"
    fill_in "パスワード", with: "password"
    fill_in "もう一度入力してください", with:"password"
    click_on "登録する"

    expect(page).to have_content "ユーザーリスト"
  end

  before do
    User.create!(name: "test", email: "test@test.com", password: "testtest")
  end
  scenario "一覧" do
    visit admin_users_path

    expect(page).to have_content "ユーザーリスト"
  end

  scenario "名前更新" do
    visit admin_users_path
    click_on "編集"
    fill_in "名前", with:"testtest"
    fill_in "メールアドレス", with:"test@test.com"
    fill_in "パスワード", with:"testtest"
    fill_in "もう一度入力してください", with: "testtest"
    click_on "更新する"

    expect(page).to have_content "ユーザーリスト"
  end

  scenario "閲覧" do
    visit admin_users_path
    click_on "詳細"

    expect(page).to have_content "マイページ"
  end

  scenario "名前更新" do
    visit admin_users_path
    click_on "削除"

    expect(page).to have_content "削除しました"
  end

end
