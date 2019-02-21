FactoryBot.define do
  factory :todotask do
    name { "Factoryで作ったデフォルトのタスク名1" }
    content { "Factoryで作ったデフォルトの内容1" }
    status { 1 }
    deadline { "2019-03-01 00:00:00" }
    priority { 1 }
  end

  factory :second_todotask, class: Todotask do
    name { "Factoryで作ったデフォルトのタスク名2" }
    content { "Factoryで作ったデフォルトの内容2" }
    status { 2 }
    deadline { "2019-03-02 00:00:00" }
    priority { 2 }
  end
end
