## [AngelList](https://angel.co) for Alchemists

[![Continuous Integration](https://img.shields.io/travis/mtwilliams/angellist/master.svg)](https://travis-ci.org/mtwilliams/angellist)
[![Code Coverage](https://img.shields.io/coveralls/mtwilliams/angellist/master.svg)](https://coveralls.io/github/mtwilliams/angellist)
[![Documentation](http://inch-ci.org/github/mtwilliams/angellist.svg)](http://inch-ci.org/github/mtwilliams/angellist)
[![Package](https://img.shields.io/hexpm/dt/angellist.svg)](https://hex.pm/packages/angellist)

:construction: *Work in progress!* :construction:

AngelList client library for Elixir.

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

  * Run mix deps.get to install.

  * In you configuration, like `config/config.exs` or `config/prod.exs` set your defaults:

  ```elixir
  config :angellist,
    client_id: "df3891820fb53e581399bd6c43bcb3b3e365f795a7ffbc71",
    client_secret: "e2d46dba8cf1e6a758b698d5e97734d9d31a79e640f96b75",
    access_token: "e5c0e9af2be1b491674d2a06ddbb2c256f09c887fab89eba"
  ```

### Example

```elixir
iex> client = AngelList.client

iex> IO.inspect AngelList.User.me(client)
%AngelList.User{
  id: 155,
  url: "http://angel.co/naval",
  image: "https://s3.amazonaws.com/photos.angel.co/users/155-medium?1308634544",
  name: "Naval Ravikant",
  bio: "Sweat - AngelList, Venture Hacks, Vast, Epinions; Money - Twitter, Heyzap, SnapLogic",
  investor: true,
  followers: 13375,
  links: %{
    blog: "http://startupboy.com/",
    bio: "http://startupboy.com/about/",
    twitter: "http://twitter.com/naval",
    facebook: "http://www.facebook.com/navalr",
    linkedin: "http://www.linkedin.com/in/navalr"
  },
  locations: [
    %AngelList.Location{
      id: 1692,
      url: "http://angel.co/san-francisco",
      term: "san francisco",
      humanized: "San Francisco""
    }
  ],
  roles: [
    %AngelList.Role{
      id: 9305,
      url: "http://angel.co/seed-funds",
      term: "seed funds",
      humanized: "Seed Fund"
    },
    %AngelList.Role{
      id: 14725,
      url: "http://angel.co/entrepreneur-1",
      term: "entrepreneur",
      humanized: "Entrepreneur"
    }
  ]
}
```

## How do I contribute?

You don't. Not yet.
