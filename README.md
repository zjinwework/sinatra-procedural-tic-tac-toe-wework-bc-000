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

You can startup a local development server for this application by first running `bundle` to install all the gem dependencies for this application and then running `shotgun`.

```
$ bundle
Using rake 10.4.2
etc...
Using bundler 1.10.6
Bundle complete! 10 Gemfile dependencies, 29 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.

$ shotgun
== Shotgun/Thin on http://127.0.0.1:9393/
Thin web server (v1.6.3 codename Protein Powder)
Maximum connections set to 1024
Listening on 127.0.0.1:9393, CTRL+C to stop
```

If you immediately navigate to `http://localhost:9393` you'll see a 404 error from sinatra because your application is not currently programmed to respond to a GET request to '/'. You'll fix that in a bit, move on.

## `models/tic_tac_toe.rb`

The first set of tests you should get passing are located in `01_tic_tac_toe_spec.rb`. They are unit tests for our Tic Tac Toe model and are totally isolated from our Web Application or our Controller. Run `learn spec/01_tic_tac_toe_spec.rb --fail-fast` to focus on just those failing tests one at a time.

Most of the methods required for our `TicTacToe` model will be familiar to you if you've built other version of Tic Tac Toe in Ruby.

We'll go over the requirements for each of the methods we test for in this lab.

### `#initialize`

Initialize just has to setup the default game state by creating an instance variable `@board` set to an array with 9 empty `" "` strings.

### `#board` and `#board=` attribute reader and writers.

Provide a `#board=` and a `#board` method to read and write to the internal instance variable `@board`.

### `#move`

`#move` will accept an index in the board to update along with a token to place in that position.

### `#position_taken?`

This method will accept an index in the board to check if it is occupied. If the position contains anything besides an unoccupied space, the method should return true, otherwise, it should return false to indicate the position in the board is available.

### `#turn_count`

This method returns the number of turns that have been played based on the board in `@board`

### `#current_player`

The `#current_player` method should use the `#turn_count` method to determine if it is `"X"`'s turn or `"O"`'s.

### `WIN_COMBINATIONS`

Define a constant in `models/tic_tac_toe.rb` `WIN_COMBINATIONS` within the `TicTacToe` class and set it equal to a nested array filled with the index values for the various win combinations in tic tac toe.

```ruby
# within the body of TicTacToe

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5]  # Middle row
  # ETC, an array for each win combination
]

# the rest of the TicTacToe class definition
```

### `#won?`

Your `#won?` method should return false/nil if there is no win combination present in the board and return the winning combination indexes as an array if there is a win. Use your `WIN_COMBINATIONS` constant in this method.

### `#draw?`

Build a method `#draw?` that returns true if the board has not been won and is full and false if the board is not won and the board is not full, and false if the board is won.

### `#winner`

The `#winner` method should return the token, "X" or "O" that has won the game given a winning board.

### `#turns`

We'll be initializing a new instance of a `TicTacToe` game upon every form submission from the user. Whether it's the first turn or the last, we'll be starting up a new game and updating it with all the turns that have occurred, basically fast-forwarding a new instance of `TicTacToe` to any given turn or game state using this method.

This method will accept a hash in the form of `{0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => "X", 5 => " ", 6 => " ", 7 => " ", 8 => " "}`, which would represent a game after the first turn where X moved into the middle.

Each key value pair in the hash represents a potential turn and the move that might have occurred. The key value pair `4 => "X"` means that `X` has at some point moved into the middle position. The key value pair of `0` => "" means that a move to the top left has not occurred.

With this hash, the `#turn` method should iterate over the key value pairs of the hash and update the game by sending the `#move` method with the appropriate data from the hash's key value pairs.

For example:
```ruby
game_state = {0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => "X", 5 => " ", 6 => " ", 7 => " ", 8 => " "}

game = TicTacToe.new
game.turns(game_state)

game.turn_count #=> 1, only one valid move has been made.
game.current_player #=> "O", it is O's turn.
game.board #=> [" ", " ", " ", " ", "X", " "," ", " ", " "] X in middle.
```

You'll see why this behavior is required shortly.

## Tic Tac Toe Integration Tests

Once our model is ready to handle the majority of the actual game logic, we need to build controller actions and routes to handle the HTTP requests for our application and the views those controllers will use to generate the appropriate HTML response.

### GET / - New Game

When a user goes to `/` for the first time, the application should initialize new game of Tic Tac Toe for the player and present them an HTML interface with which to interact with that game.

#### 1. Request Basics

Your `Application` controller must respond to a `GET` request at `/` with a valid 200 status code.

Within your controller action response to `GET /`, you also must instantiate an instance of `TicTacToe`. You should assign this instance to an instance variable in the controller `@game`. Your views are going to use this object.

#### 2. HTML for GET '/' - A Game Board

When a user visits `/` to start a new game, they should see a "Welcome to Tic Tac Toe!". Have your `GET /` controller action render an ERB template `index.erb`. You have to create that template and add the correct HTML in a file `views/index.erb`.

`views/index.erb` will also have to setup the game board and form.

Build a `<form>` tag in `index.erb` responsible for packaging the game data, including the moves a user makes, and submitting the input to the `Application` controller via a `POST` request to the same `/` URL.
You'll then need to add the HTML required for a Tic Tac Toe board. To setup a 3 x 3 grid of cells for the board we're going to use the HTML `<table>` element to build a table with 3 `<tr>` rows and within each row, 3 `<td>` cells. Nest this `<table>` within the `<form>` built above.

The next step is to fill each cell with a corresponding form input. Each `<input>` should be appropriately named after the the corresponding index of the board the input represents. For example, the top left input would be named `0`, `<input type="text" name="0">`. That'll make it easy to pass the values from the form to our `TicTacToe` instance because it is built to take in index-based turns.

Finally, add a submit button to the form by using an `<input type="submit" value="Submit Move" id="submit"/>`. You can put this anywhere within the `<form>` tag.

Once the form is configured correctly to submit to `POST /` and it has a submit button so you can actually submit it in your browser, the very next thing to do is simply build a `POST /` route that can accept the form submission request. It doesn't have to do anything else yet, let's just make sure it's not 404 and our application can at least handle the form submission.

### POST / - Submitting a Move

#### Updating the game based on form input

Let's think about are the requirements for processing the Tic Tac Toe form.

1. We have to initialize an instance of TicTacToe.
2. The `params` hash will have all the data about the current game and what moves have been taken. We have to send that data to our TicTacToe instance using the `#turns` method to update the game to the current state.

Start by meeting those requirements. In your `post '/'` action in the `Application` controller, initialize an instance of TicTacToe in a `@game` instance variable.

Then call `#turns` on that instance passing in the parameters. If your model is correct, after a player visits a new game at `GET /`, if they fill in the middle input named `4` with an "X" and submit the form, the `@game` instance in the `POST /` action should end up in a game state on the second turn with an "X" in the middle of the board.

#### Updating the game form in index.erb

After a move is submitted the `POST /` action should generally re-render the `index.erb` to display an updated game board to the user. If the `POST /` action correctly created a new instance of TicTacToe in `@game` and updated it based on the moves submitted in via the form, then the `index.erb` can use `@game` to dynamically update the state of the form. If the first played moved into the middle square with an "X" and hit submit, the next page should show a board with an "X" in the middle. That input should also be locked so the "O" player can't cheat and edit the previous moves. We can do that by setting a `readonly` attribute on the input.

Update all the `<input>` tags in `index.erb` to use `@game` and ERB to dynamically inject HTML based on the properties in `@game`. For example, when we're writing an input, say the middle cell, it would normally look like:

```html
<input type="text" name="4" />
```

But what if the player already moved into the middle? That input's value should be set to an "X". How can we do that? Can we just use ERB within the `<input>` tag to prefill the `value` attribute? You bet. Given an `@game` in the controller action:

```erb
<input type="text" name="4" value="<%= @game.board[4] %>" />
```

You'll have to do something like that to conditionally set the `readonly` attribute of the input of that position in the board is taken.

Once the inputs' values are updated and the readonly attribute is properly set for filled in positions, we can now play through a game of Tic Tac Toe. Try it out. The board will accurately update upon every move. Except it doesn't stop if someone has won or if there is a draw. Let's add that to our program.

#### Winning the game

Our `POST /` controller action in `Application` controller shouldn't render the `index.erb` and show the game board if the game was just won. Rather, we should render a new HTML template, let's call it `winner.erb`.

Add a conditional in your `POST /` controller action to check if the game is won and render a template `winner.erb` instead of `index.erb`.

The `winner.erb` template should use `@game` and ERB to dynamically insert the winner of the game in the congratulations message, for example, if X has won (what method on `@game` can we call to get the winner?), `winner.erb` should display: `Congratulations X, you won the game!`.

Once you get those tests to pass, you can now play a more realistic game of Tic Tac Toe. The board will update correctly and when a player has won, the game will stop and you'll see a congratulations message.

#### A draw game

The final step is to account for a draw. It's very similar to accounting for a win. In your controller, conditionally render a `draw.erb` template if the `@game` is a draw. The `draw.erb` template can just say `Cats Game!`.

That's it, once you've implemented that, the entire test suite should pass and you shoud be able to play an accurate game of Tic Tac Toe in your browser! Congratulations! Submit your solution with `learn submit`

## Conclusion

### Magic Javascript to Prevent Cheating

If you play your game in a browser, you'll notice that there's something preventing you from cheating or putting invalid input in the board. If it is O's turn and you try to enter an X into a position, something is automatically correcting that token to an O. In fact if you enter anything besides the valid token, the board will update as though you entered the valid token. What's doing that?

Open up `views/layout.erb` and look at lines 12-16 in the `<head>`.

```html
<script>
  var currentToken = "<%= @game.current_player if @game && @game.respond_to?(:current_player) %>"
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/javascripts/app.js"></script>
```

You'll notice that we added some Javascript to your layout. `var currentToken = "<%= @game.current_player if @game && @game.respond_to?(:current_player) %>"` is setting a javascript variable equal to the current_player token from the instance variable `@game` you create in your controller actions.

Then we load jQuery and another javascript file located in `public/javascripts/app.js`. Open it up. In there is some javascript that provides the functionality of validating move input. It's annotated with explanation comments, give it a read.

### A New Theme

Our game works and that's great, but our design is a bit lacking. We included another stylesheet for Tic Tac Toe. If you want to see a Web Based CLI Design, do the following.

In `views/layouts.erb`, comment out the `/stylesheets/app.css` stylesheet and comment in the `/stylesheets/terminal.css` stylesheet.

```html
<!-- <link rel="stylesheet" href="/stylesheets/app.css"> -->
<link rel="stylesheet" href="/stylesheets/terminal.css">
```

Then go to your `views/index.erb` and update your `<h1>` Welcome message to:

```html
<h1><span class="path">~/tic-tac-toe</span> <span class="prompt">// <span class="heart">♥</span></span><span class="command"> ./bin/tictactoe</span></h1>
```

Save everything and reload your application in your browser. Look familar? Pretty cool, right?

### Watching Your Tests Play the Game - OS X Only

We use Capybara to write our integration tests. When we run our tests, Capybara is using a "headless" web browser to run our tests. What does that mean? Imagine a web browser like Chrome that you just can't see. It still performs all the actions of a web browser, but it has no Graphical User Interface (GUI). That's a headless browser. They are great for testing web applications. But we can tell Capybara to use our actual GUI browser and as the tests run, we'll be able to see our code control the browser.

First, you'll need to install [Firefox](https://www.mozilla.org/en-US/firefox/new/).

Then, open `specs/02_tic_tac_toe_integration_spec.rb` and on the first line, edit the opening `describe` block and pass a `:js => true` options hash as a second argument. It should look like:

```ruby
describe './app.rb - Tic Tac Toe Sinatra', :js => true do
```

Now run your tests with `learn` and watch Firefox come to life. It's okay if some of the tests are now failing. You can undo any changes you've made since to get them to pass.
