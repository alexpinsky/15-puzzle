## 15 Puzzle implementation

### Usage

**Installation**
```
chmod +x bin/install
bin/install
```
**Running the game**
```
bin/start
```
**Running the tests**
```
bin/test
```

### Design considerations
The primary purpose of this architecture is to enforce a separation of concerns between the core of our product (the 15 puzzle game) and the delivery mechanisms (CLI application).

The game can be found under ```/lib```.

The CLI app can be found under ```/apps```.

In terms of the application design, I chose to allow **stateless, persistence ignorant** implementation to support the different delivery mechanisms. For example, it is very easy to design a stateful CLI application. That is, as long as the app is running, the state of the game exists. This kind of implementation won't support the web's stateless nature, where the application state only exists through the request lifetime. Therefore there's a *load game* initial support that allows game initialization from an existing state.

### Time trade-offs
***Player*** - a Player entity is missing to allow - best score and loading/saving the game.
***Load/Save a game*** - to allow resuming a game and to support web app.
***InputParser*** - is implemented in a way that is very coupled to the game moves. If it needs to support other application level commands (retry, load, save, etc.), it will need to get refactored.  It only supports the *exit* command through an exception, which is not very scalable flow control for implementing other commands.

### References
The game logic implementation is taken from https://rosettacode.org/wiki/15_puzzle_game
