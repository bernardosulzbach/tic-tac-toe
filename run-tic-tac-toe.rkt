#lang racket

(require "tic-tac-toe.rkt")

(define (sow-remaining lst v freq n)
  (if (equal? freq n)
    (cons v (sow-remaining lst v freq 0))
    (if (empty? lst)
      empty
      (cons (first lst) (sow-remaining (rest lst) v freq (+ n 1))))))

; Inserts v at every freq-th position of the list.
(define (sow lst v freq)
  (sow-remaining lst v freq 0))

; Converts a game to a string.
(define (game-to-string a-game)
  (apply 
    string-append
    (sow
      (map
        (lambda (s) (if (symbol? s) (symbol->string s) " "))
        (vector->list (game-state a-game))) "\n" 3)))

(define (display-game a-game)
  (displayln (game-to-string a-game)))

(define empty-game (game (vector empty empty empty empty empty empty empty empty empty)))
(display-game (solve empty-game))
