require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  before do
    FactoryBot.create(:todotask)
    FactoryBot.create(:second_todotask)
  end

  scenario "タスク一覧のテスト" do
    visit todotasks_path

    expect(page).to have_content "Factoryで作ったデフォルトの内容1"
    expect(page).to have_content "Factoryで作ったデフォルトの内容2"
  end

  before do
    User.create!(name: 'example', email:'example@example.com', password:'123456')
  end
  scenario "タスク作成のテスト" do
    #ログインページ来訪
    visit new_session_path
    fill_in 'メールアドレス', with: 'example@example.com'
    fill_in 'パスワード', with: '123456'
    click_button 'Login'

    #ログインに成功したら表示される
    expect(page).to have_content "ログインに成功しました"

    #タスク作成
    fill_in 'タスク名', with: 'task01'
    fill_in 'タスク詳細', with: 'test_task01'
    select '未着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '2月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'

    click_on '登録する'

    #成功したらこのページに飛ぶ
    expect(page).to have_content "test_task01"
  end

  scenario "タスク詳細のテスト" do
    Todotask.create!(name: "test03", content:"testtesttest3", status: 1, deadline:"2019-03-04 00:00:00", priority: 1)
    visit todotasks_path
    #save_and_open_page
    page.first(:link, "詳細").click
    expect(page).to have_content "タスク詳細"
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit todotasks_path
    expect(Todotask.order("created_at desc").map(&:id)).to eq [10,9]
  end

  scenario "並び替え機能のテスト" do
    Todotask.create!(name: "test04", content:"testtesttest4", status: 1, deadline:"2018-03-04 00:00:00", priority: 1)
    visit todotasks_path
    click_on '終了期限でソートする'
    expect(Todotask.order("deadline desc").map(&:id)).to eq [12,11,13]
  end

  scenario "タスク名、ステータス両方入力時の検索テスト" do
    visit todotasks_path
    fill_in 'タスク名', with: 'Factoryで作ったデフォルトのタスク名1'
    select '未着手', from: 'ステータス'
    click_on '登録する'
    expect(page).to have_content "Factoryで作ったデフォルトのタスク名1"
  end

  scenario "タスク名入力時の検索テスト" do
    visit todotasks_path
    fill_in 'タスク名', with: 'Factoryで作ったデフォルトのタスク名1'
    click_on '登録する'
    expect(page).to have_content "Factoryで作ったデフォルトのタスク名1"
  end

  scenario "ステータス入力時の検索テスト" do
    visit todotasks_path
    select '未着手', from: 'ステータス'
    click_on '登録する'
    expect(page).to have_content "Factoryで作ったデフォルトのタスク名1"
  end

  scenario "空入力時の検索テスト" do
    visit todotasks_path
    click_on '登録する'
    expect(page).to have_content ""
  end
end
