require 'rails_helper'

RSpec.describe Todotask, type: :model do
  it "タスク名が空だった場合バリデーションが通らない" do
    todotask = Todotask.new(name: "", content:"失敗のテスト", status: 1, deadline: "2019-03-03 00:00:00", priority: 2)
    expect(todotask).not_to be_valid
  end

  it "タスク名が入っていればバリデーションが通る" do
    todotask = Todotask.new(name: "sample", content:"成功のテスト", status: 2, deadline: "2019-03-04 00:00:00", priority: 1)
    expect(todotask).to be_valid
  end
end
