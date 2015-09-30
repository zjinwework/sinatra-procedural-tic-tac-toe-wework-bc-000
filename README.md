---
tags:
languages:
resources:
---

# Sinatra Tic Tac Toe

## Objectives

1. Build an MVC Sinatra Application.
2. Use a model without a database.
3. Respond to `get` requests with Sinatra.
4. Render a HTML form with dynamic input values.
5. Response to `post` requests with Sinatra.
6. Pass form data through `params` to a model.
7. Conditionally render different templates.

## Overview

### Congratulations!!! You're amazing.

No matter how long you've been programming the challenge in this lesson is a major milestone. As trivial as building a web-based Tic Tac Toe application might sound, the techniques and concepts you'll implement our the foundations of every modern web application. Sure, being able to build Tic Tac Toe isn't the same as building the next Airbnb or Twitter, but I promise that anyone building applications at that scale at some point had to learn how to build something at this scale. There are not shortcuts.

### Demo

When you're done, your Tic Tac Toe application should function something like this:

<iframe width="853" height="480" src="https://www.youtube.com/embed/P3fojBzzlI8?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>

We're building a 2 player web-based Tic Tac Toe. Every form submission will represent an individual turn by a player. The board during a game should accurately represent the game state. Additionally, the board should automatically lock positions that have already been taken. The game should play until someone wins, after which, the application should congratulate the winning player. In the event of a draw, the application should inform the players of the Cat's Game.

### Project Structure

We've given you a scaffold for your project. This project follows the Model-View-Architecture (MVC) pattern for web applications so we're purposely configuring Sinatra to support MVC structure, so certain files might seem oddly placed, but we're doing it on purpose. Don't let any of that slow you down, just code where you think you should be coding.

```
├── Gemfile
├── Rakefile
├── app.rb
├── config
│   └── environment.rb
├── config.ru
├── models
│   └── game.rb
├── public
│   ├── images
│   ├── javascripts
│   │   └── app.js
│   └── stylesheets
│       ├── app.css
│       └── terminal.css
├── spec
│   ├── sinatra_tic_tac_toe_spec.rb
│   └── spec_helper.rb
└── views
    ├── draw.html.erb
    ├── index.html.erb
    ├── layout.erb
    └── winner.html.erb
```

#### `Gemfile`, `Rakefile`

These files setup some tools and gems for our project and can mostly be ignored. Make sure to run `bundle` before starting this project so that you have all the required gems.

#### `app.rb` - Our Application Controller

`app.rb` is going to defines our main controller, `Application`, inheriting from `Sinatra::Base`. You'll be building your two routes, `get '/'` and `post '/'` here.

#### `config/environment.rb`

Between Sinatra and our tests, this application has a somewhat complex environment. To consolidate the code for loading the requirements of the application, we created an `config/environment.rb` file that gets everything setup and ready to go. You do not ever need to edit this.

#### `config.ru`

`config.ru` is the main entry point for our application. `config.ru` loads our environment and starts our web application. `shotgun`, `rackup`, and our tests use this file to know how to start our application. You'll never need to edit this.

#### 'models/tic_tac_toe.rb'

`models/tic_tac_toe.rb` defines our main model, a `TicTacToe` class that entirely encapsulates all the logic and data required to play a game of tic tac toe in almost any interface, Web or CLI.

#### 'public/'

The `public` directory contains some static assets such as CSS and Javascript that will make our game behave and look decent in a browser. You do not need to ever edit these files but reading them would be fun.

#### `spec/`

Our `spec` directory contains our tests. `01_tic_tac_toe_spec.rb` includes tests for our `TicTacToe` model. `02_tic_tac_toe_integration_spec.rb` contains Capybara Integration Tests for our entire web application. Everything will need to be working to get these to pass.

#### `views`

Our views contain the HTML and ERB templates for our application's HTML interface. You'll have to build and edit 3 of these views, `index.erb`, `winner.erb`, and `draw.erb`. `layout.erb` provides a general layout to wrap all our views and you can mostly ignore this file. However, there are some bonuses and easter-eggs in this lab that will require you to edit this file.

### Development Server



1. Project Structure
2. Running the development server
3. Running / reading the tests
4. TicTacToe Model
5. Game Form
6. Post Controller
4. The console
5. Hints
6. Javascript
7. Theme
