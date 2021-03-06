
FactoryGirl.define do

  factory :user do
    sequence(:username)  { |n| "person#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :creator do
    sequence(:username)  { |n| "person#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :project do
    title   "Example project"
    desc    "example project's description here"
    due_date 3.days.from_now
    user
  end

  factory :task do
    sequence(:title)  { |n| "Example task Nr #{n}" }
    desc    "example task's description here"
    due_date 3.days.from_now
    project
    creator
  end

  factory :tasklist do
    title   "Milestone 1"
    desc    "example milestone description here"
    due_date 3.days.from_now
    project
    creator
  end

  factory :time_session do
    task
    user
  end

  factory :profile do
    sequence(:forename) { |n| "Vorname #{n}" }
    sequence(:surname) { |n| "Namchname #{n}" }
    user
  end

	factory :svn_repository, :class => Tools::SvnRepository do
		title "Debian; Debburn"
		url		"svn://svn.debian.org/debburn"
	end

  factory :svn_pw_repository, :class => Tools::SvnRepository do
    title "test"
    url "asd"
    svn_username "asd"
    svn_password "asd"
  end

end

