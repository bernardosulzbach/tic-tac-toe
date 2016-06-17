# Tic Tac Toe

This repository contains code for the popular paper-and-pencil game known as Tic
Tac Toe (also known as Noughts and Crosses).

# Racket Code

You will need, as you may assume, a Racket distribution in order to run the
Racket programs.

Running the interactive game will allow you to play against the computer.

This should be as simple as

```bash
$ racket game.rkt
```

The algorithm is an implementation of naïve minimax. The implementation is very
slow due to the lack of optimizations. This may be fixed in the future.

# Continuous Integration Status

[![Build Status](https://travis-ci.org/mafagafogigante/tic-tac-toe.svg?branch=master)](https://travis-ci.org/mafagafogigante/tic-tac-toe)
