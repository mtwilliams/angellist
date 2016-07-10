## [AngelList](https://angel.co) for Alchemists

[![Continuous Integration](https://img.shields.io/travis/mtwilliams/angellist/master.svg)](https://travis-ci.org/mtwilliams/angellist)
[![Code Coverage](https://img.shields.io/coveralls/mtwilliams/angellist/master.svg)](https://coveralls.io/github/mtwilliams/angellist)
[![Documentation](http://inch-ci.org/github/mtwilliams/angellist.svg)](http://inch-ci.org/github/mtwilliams/angellist)
[![Package](https://img.shields.io/hexpm/dt/angellist.svg)](https://hex.pm/packages/angellist)

:construction: *Work in progress!* :construction:

(An opinionated) AngelList client library for Elixir.

## Why should I use it?

You shouldn't. Not yet.

### Features

  * Minimalist.

## How do I use it?

### Installation

  * Add it as a Mix dependency in the project.

  ```elixir
  def deps do
    [{:angellist, "~> 0.0.0"}]
  end
  ```

  * Run `mix deps.get` to install.

  * In you configuration, like `config/config.exs` or `config/prod.exs` set your defaults:

  ```elixir
  # These are not real credentials...
  config :angellist,
    client_id: "df3891820fb53e581399bd6c43bcb3b3e365f795a7ffbc71",
    client_secret: "e2d46dba8cf1e6a758b698d5e97734d9d31a79e640f96b75",
    access_token: "e5c0e9af2be1b491674d2a06ddbb2c256f09c887fab89eba"
  ```

### Example

```elixir
iex(1)> client = AngelList.Client.new(access_token: "...")
%AngelList.Client{access_token: "...",
 client_id: nil, client_secret: nil,
 options: %{base_url: "https://api.angel.co/", proxy: nil, timeout: 5000,
   user_agent: "Elixir/1.3.1"}}

iex(2)> AngelList.User.get(client, id: 155)
%AngelList.User{biography: "Sweat: @angellist , @venture-hacks @vast @epinions ;  Money: @twitter @heyzap @uber ",
 criteria: nil, does: "", done: "", followers: 45504, id: 155, investor: true,
 links: %{aboutme: nil, behance: nil, blog: "http://startupboy.com/",
   dribbble: nil, facebook: "http://www.facebook.com/navalr", github: nil,
   linkedin: "http://www.linkedin.com/in/navalr", resume: nil,
   twitter: "http://twitter.com/naval",
   website: "http://startupboy.com/about/"},
 locations: [%AngelList.LocationTag{id: 1692, name: "san francisco",
   pretty: "San Francisco", slug: "san-francisco",
   url: "https://angel.co/san-francisco"}], name: "Naval Ravikant",
 portrait: "https://d1qb2nb5cznatu.cloudfront.net/users/155-medium_jpg?1462899600",
 roles: [%AngelList.RoleTag{id: 9305, name: "seed funds", pretty: "Seed Fund",
   slug: "seed-funds", url: "https://angel.co/seed-funds"},
  %AngelList.RoleTag{id: 14725, name: "entrepreneur", pretty: "Entrepreneur",
   slug: "entrepreneur-1", url: "https://angel.co/entrepreneur-1"},
  %AngelList.RoleTag{id: 9299, name: "advisors", pretty: "Advisor",
   slug: "advisors", url: "https://angel.co/advisors"},
  %AngelList.RoleTag{id: 14726, name: "developer", pretty: "Developer",
   slug: "developer", url: "https://angel.co/developer"}],
 skills: [%AngelList.SkillTag{id: 23388, name: "c", pretty: "C", slug: "c-2",
   url: "https://angel.co/c-2"},
  %AngelList.SkillTag{id: 15592, name: "html", pretty: "HTML", slug: "html",
   url: "https://angel.co/html"},
  %AngelList.SkillTag{id: 14781, name: "javascript", pretty: "Javascript",
   slug: "javascript", url: "https://angel.co/javascript"},
  %AngelList.SkillTag{id: 14775, name: "python", pretty: "Python",
   slug: "python", url: "https://angel.co/python"}], slug: "naval",
 url: "https://angel.co/naval"}
```

## How do I contribute?

You don't. Not yet.
