#lang racket

(require rackunit)
(require "tic-tac-toe.rkt")
(require/expose "tic-tac-toe.rkt" (count-plays))

(check-equal? (count-plays (game (vector 'A empty empty 'B 'A empty empty empty empty)) 'A) 2)
