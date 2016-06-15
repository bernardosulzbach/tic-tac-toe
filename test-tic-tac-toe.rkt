#lang racket

(require rackunit)
(require "tic-tac-toe.rkt")
(require/expose "tic-tac-toe.rkt" (count-plays game-evaluate-horizontally))

(check-equal? (count-plays (game (vector empty empty empty empty empty empty empty empty empty)) 'A) 0)
(check-equal? (count-plays (game (vector empty empty empty empty empty empty empty empty empty)) 'B) 0)

(check-equal? (count-plays (game (vector 'A empty empty empty empty empty empty empty empty)) 'A) 1)
(check-equal? (count-plays (game (vector 'A empty empty empty empty empty empty empty empty)) 'B) 0)

(check-equal? (count-plays (game (vector 'A empty empty empty empty 'A empty empty empty)) 'A) 2)
(check-equal? (count-plays (game (vector 'A empty empty empty empty 'A empty empty empty)) 'B) 0)
(check-equal? (count-plays (game (vector 'A empty empty empty empty 'B empty empty empty)) 'A) 1)
(check-equal? (count-plays (game (vector 'A empty empty empty empty 'B empty empty empty)) 'B) 1)
(check-equal? (count-plays (game (vector 'B empty empty empty empty 'B empty empty empty)) 'A) 0)
(check-equal? (count-plays (game (vector 'B empty empty empty empty 'B empty empty empty)) 'B) 2)

(check-equal? (game-evaluate-horizontally (game (vector empty empty empty empty empty empty empty empty empty))) empty)
(check-equal? (game-evaluate-horizontally (game (vector 'A empty empty empty empty empty empty empty empty))) empty)
(check-equal? (game-evaluate-horizontally (game (vector 'A 'A empty empty empty empty empty empty empty))) empty)
(check-equal? (game-evaluate-horizontally (game (vector 'A 'A 'A empty empty empty empty empty empty))) 'A)
(check-equal? (game-evaluate-horizontally (game (vector empty empty empty 'A 'A 'A empty empty empty))) 'A)
(check-equal? (game-evaluate-horizontally (game (vector empty empty empty empty empty empty 'A 'A 'A))) 'A)
