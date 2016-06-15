#lang racket

(require rackunit)
(require "tic-tac-toe.rkt")
(require/expose "tic-tac-toe.rkt" (count-plays))

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

(check-equal? (game-evaluate (game (vector empty empty empty empty empty empty empty empty empty))) empty)
(check-equal? (game-evaluate (game (vector 'A empty empty empty empty empty empty empty empty))) empty)
(check-equal? (game-evaluate (game (vector 'A 'A empty empty empty empty empty empty empty))) empty)

; Horizontals
(check-equal? (game-evaluate (game (vector 'A 'A 'A empty empty empty empty empty empty))) 'A)
(check-equal? (game-evaluate (game (vector empty empty empty 'A 'A 'A empty empty empty))) 'A)
(check-equal? (game-evaluate (game (vector empty empty empty empty empty empty 'A 'A 'A))) 'A)

(check-equal? (game-evaluate (game (vector 'B 'B 'B empty empty empty empty empty empty))) 'B)
(check-equal? (game-evaluate (game (vector empty empty empty 'B 'B 'B empty empty empty))) 'B)
(check-equal? (game-evaluate (game (vector empty empty empty empty empty empty 'B 'B 'B))) 'B)

; Verticals
(check-equal? (game-evaluate (game (vector 'A empty empty 'A empty empty 'A empty empty))) 'A)
(check-equal? (game-evaluate (game (vector empty 'A empty empty 'A empty empty 'A empty))) 'A)
(check-equal? (game-evaluate (game (vector empty empty 'A empty empty 'A empty empty 'A))) 'A)

(check-equal? (game-evaluate (game (vector 'B empty empty 'B empty empty 'B empty empty))) 'B)
(check-equal? (game-evaluate (game (vector empty 'B empty empty 'B empty empty 'B empty))) 'B)
(check-equal? (game-evaluate (game (vector empty empty 'B empty empty 'B empty empty 'B))) 'B)

; Diagonals
(check-equal? (game-evaluate (game (vector 'A empty empty empty 'A empty empty empty 'A))) 'A)
(check-equal? (game-evaluate (game (vector empty empty 'A empty 'A empty 'A empty empty))) 'A)

(check-equal? (game-evaluate (game (vector 'B empty empty empty 'B empty empty empty 'B))) 'B)
(check-equal? (game-evaluate (game (vector empty empty 'B empty 'B empty 'B empty empty))) 'B)
