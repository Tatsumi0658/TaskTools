require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  scenario "タスク一覧のテスト" do
    Todotask.create!(name: "test01", content:"testtesttest", status: 1, deadline:"2019-03-03 00:00:00", priority: 1)
    Todotask.create!(name: "test02", content:"samplesamplee", status: 2, deadline:"2019-03-01 00:00:00", priority: 2)

    visit todotasks_path

    expect(page).to have_content "testtesttest"
    expect(page).to have_content "samplesamplee"
  end

  before do
    User.create!(name: 'example', email:'example@example.com', password:'123456')
  end
  scenario "タスク作成のテスト" do
    #ログインページ来訪
    visit new_session_path
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: '123456'
    click_button 'Login'

    #ログインに成功したら表示される
    expect(page).to have_content "ログインに成功しました"

    #タスク作成
    fill_in 'Name', with: 'task01'
    fill_in 'Content', with: 'test_task01'
    select '未着手', from: 'Status'
    select '2019', from: 'todotask_deadline_1i'
    select 'February', from: 'todotask_deadline_2i'
    select '高', from: 'Priority'

    click_on '登録'

    #成功したらこのページに飛ぶ
    expect(page).to have_content "test_task01"
  end

  scenario "タスク詳細のテスト" do
    Todotask.create!(name: "test03", content:"testtesttest3", status: 1, deadline:"2019-03-04 00:00:00", priority: 1)
    visit todotasks_path
    #save_and_open_page
    click_on '詳細'
    expect(page).to have_content "タスク詳細"

  end
end
