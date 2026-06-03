import Config

config :northwind_me,
  ecto_repos: [NorthwindMe.Repo]

config :northwind_me, NorthwindMe.Repo, database: "northwind_me_repo.db"
