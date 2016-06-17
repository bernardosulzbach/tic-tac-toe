#lang racket

(require "tic-tac-toe.rkt")

(displayln "Computer against computer...")
(displayln (game-to-string (solve (make-empty-game))))
