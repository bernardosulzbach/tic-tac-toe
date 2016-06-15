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

; Checks if the positions a, b, and c of the vector are equal symbols.
(define (three-equal-symbols? a-vector a b c)
  ; Also check that these are symbols and not something else.
  (and (symbol? (vector-ref a-vector a))
       (equal? (vector-ref a-vector a) (vector-ref a-vector b))
       (equal? (vector-ref a-vector b) (vector-ref a-vector c))))

; Evaluates the game for horizontal results.
;
; Either returns the symbol of the winner or empty if no one won.
(define (game-evaluate-horizontally a-game) 
  (local
    ((define state (game-state a-game)))
    (cond
      [(three-equal-symbols? state 0 1 2) (vector-ref state 0)]
      [(three-equal-symbols? state 3 4 5) (vector-ref state 3)]
      [(three-equal-symbols? state 6 7 8) (vector-ref state 6)]
      [else empty])))

(define (game-evaluate-vertically a-game) empty)
(define (game-evaluate-diagonally a-game) empty)

; Evaluates the game for results in all valid directions.
;
; Either returns the symbol of the winner or empty if no one won.
(define (game-evaluate a-game)
  (first-or-empty
    (filter
      (lambda (x) (not (empty? x)))
      (list
        (game-evaluate-horizontally a-game)
        (game-evaluate-vertically a-game)
        (game-evaluate-diagonally a-game)))))

; Returns whether or not the game is finished.
(define (game-finished? a-game) (not (empty? (game-evaluate a-game))))

; Stub
(define (solve game)
  (if (game-finished? game)
    game
    (solve (derive-games game))))

(provide game)
