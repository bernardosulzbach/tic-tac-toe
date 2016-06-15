#lang racket

(struct game [state])

(define X-symb 'X)
(define O-symb 'O)

; Counts how many times the specified symbol has played in the game.
(define (count-plays a-game symb)
  (vector-count (lambda (s) (equal? s symb)) (game-state a-game)))

; Determines the next player to play in the game.
(define (determine-next-to-play a-game)
  (if (> (count-plays a-game X-symb) (count-plays a-game O-symb)) O-symb X-symb))

; Stub
(define (derive-games-for-player a-game symb)
  (a-game))

; (derive-games Game) -> (listof Game?)
;
; Enumerates all games that may be derived from the specified game in a single
; turn.
(define (derive-games game)
  (derive-games-for-player game (determine-next-to-play game)))

; Returns the first element of a list of empty if the list has no elements.
(define (first-or-empty lst)
  (if (empty? lst) lst (car lst)))

(define (game-evaluate-horizontally a-game) empty)
(define (game-evaluate-vertically a-game) empty)
(define (game-evaluate-diagonally a-game) empty)

; Evaluates the game, returning either the symbol of the victorious side or
; empty if the game is not finished yet.
(define (game-evaluate a-game)
  (first-or-empty
    (filter
      (lambda (x) (not (empty? x)))
      (list
        (game-evaluate-horizontally a-game)
        (game-evaluate-vertically a-game)
        (game-evaluate-diagonally a-game)))))

; Returns whether or not the game is finished.
; Stub
(define (game-finished? a-game) #t)

; Stub
(define (solve game)
  (if (game-finished? game)
    game
    (solve (derive-games game))))

(provide game)
