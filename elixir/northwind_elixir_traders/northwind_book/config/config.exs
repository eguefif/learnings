import Config

config :northwind_book,
  ecto_repos: [NorthwindBook.Repo]

config :northwind_book, NorthwindBook.Repo, database: "northwind_book_repo.db"
