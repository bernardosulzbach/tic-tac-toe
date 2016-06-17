#lang racket

(require "tic-tac-toe.rkt")

(define (process-command g cmd)
  (game (vector-copy-and-replace (game-state g) cmd 'O)))

(define (take-player-move g)
  (displayln (game-to-string g))
  (process-command g (read)))

(define (play-game g)
  (cond
    [(game-finished? g) (displayln "Bye.")]
    [else (play-game (take-player-move (play g)))]))

(play-game (make-empty-game))
