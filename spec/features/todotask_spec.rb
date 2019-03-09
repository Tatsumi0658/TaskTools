require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  before do
    FactoryBot.create(:todotask)
    FactoryBot.create(:second_todotask)

    User.create!(name: 'example', email:'example@example.com', password:'123456')
    visit new_session_path
    fill_in 'メールアドレス', with: 'example@example.com'
    fill_in 'パスワード', with: '123456'
    click_button 'Login'

    Label.create!(name:"サポート")
  end

  scenario "タスク一覧のテスト" do
    visit todotasks_path

    expect(page).to have_content "タスク一覧"
  end

  scenario "タスク作成のテスト" do
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
    fill_in 'タスク名', with: 'task01'
    fill_in 'タスク詳細', with: 'test_task01'
    select '未着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '2月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'

    click_on '登録する'
    visit todotasks_path
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
    fill_in 'タスク名', with: 'task01'
    fill_in 'タスク詳細', with: 'test_task01'
    select '未着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '2月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'

    click_on '登録する'
    visit todotasks_path
    fill_in 'タスク名', with: 'task01'
    select '未着手', from: 'ステータス'
    click_on '検索する'
    #save_and_open_page
    expect(page).to have_content "task01"
  end

  scenario "タスク名入力時の検索テスト" do
    fill_in 'タスク名', with: 'task01'
    fill_in 'タスク詳細', with: 'test_task01'
    select '未着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '2月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'

    click_on '登録する'
    visit todotasks_path
    fill_in 'タスク名', with: 'task01'
    click_on '検索する'
    expect(page).to have_content "task01"
  end

  scenario "ステータス入力時の検索テスト" do
    fill_in 'タスク名', with: 'task01'
    fill_in 'タスク詳細', with: 'test_task01'
    select '未着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '2月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'

    click_on '登録する'
    visit todotasks_path
    select '未着手', from: 'ステータス'
    click_on '検索する'
    expect(page).to have_content "task01"
  end

  scenario "空入力時の検索テスト" do
    visit todotasks_path
    click_on '検索する'
    expect(page).to have_content "タスク一覧"
  end

  scenario "優先度でソートするテスト" do
    Todotask.create!(name: "test05", content:"testtesttest4", status: 1, deadline:"2018-03-04 00:00:00", priority: 3)
    visit todotasks_path
    click_on '優先度でソートする'
    expect(Todotask.order('priority asc').map(&:id)).to eq [25,26,27]
  end

  scenario "ページネーションのテスト" do
    fill_in 'タスク名', with: 'task01'
    fill_in 'タスク詳細', with: 'test_task01'
    select '未着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '2月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'
    click_on '登録する'

    visit new_todotask_path

    fill_in 'タスク名', with: 'task02'
    fill_in 'タスク詳細', with: 'test_task02'
    select '着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '3月', from: 'todotask_deadline_2i'
    select '低', from: '優先度'
    click_on '登録する'

    visit new_todotask_path

    fill_in 'タスク名', with: 'task03'
    fill_in 'タスク詳細', with: 'test_task03'
    select '未着手', from: 'ステータス'
    select '2020', from: 'todotask_deadline_1i'
    select '4月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'
    click_on '登録する'

    visit new_todotask_path

    fill_in 'タスク名', with: 'task04'
    fill_in 'タスク詳細', with: 'test_task04'
    select '未着手', from: 'ステータス'
    select '2020', from: 'todotask_deadline_1i'
    select '6月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'
    click_on '登録する'

    visit todotasks_path
    click_on 'Next'
    expect(page).to have_content "test_task01"
  end

  scenario "ラベル検索のテスト" do
    visit new_todotask_path
    fill_in 'タスク名', with: 'task01'
    fill_in 'タスク詳細', with: 'test_task01'
    select '未着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '2月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'
    check 'todotask_label_ids_12'
    click_on '登録する'
    visit todotasks_path
    select 'サポート', from: 'ラベル'
    click_on '検索する'
    expect(page).to have_content "task01"
  end

  scenario "タスク名,ステータス,ラベル検索のテスト" do
    visit new_todotask_path
    fill_in 'タスク名', with: 'task01'
    fill_in 'タスク詳細', with: 'test_task01'
    select '未着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '2月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'
    check 'todotask_label_ids_13'
    click_on '登録する'
    visit todotasks_path
    fill_in 'タスク名', with: 'task01'
    select '未着手', from: 'ステータス'
    select 'サポート', from: 'ラベル'
    click_on '検索する'
    expect(page).to have_content "task01"
  end

  scenario "ステータス,ラベル検索のテスト" do
    visit new_todotask_path
    fill_in 'タスク名', with: 'task01'
    fill_in 'タスク詳細', with: 'test_task01'
    select '未着手', from: 'ステータス'
    select '2019', from: 'todotask_deadline_1i'
    select '2月', from: 'todotask_deadline_2i'
    select '高', from: '優先度'
    check 'todotask_label_ids_14'
    click_on '登録する'
    visit todotasks_path
    select '未着手', from: 'ステータス'
    select 'サポート', from: 'ラベル'
    click_on '検索する'
    expect(page).to have_content "task01"
  end

end
