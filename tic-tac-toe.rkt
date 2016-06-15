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

; Checks if the positions a, b, and c of the vector are equal symbols.
(define (three-equal-symbols? a-vector a b c)
  ; Also check that these are symbols and not something else.
  (and (symbol? (vector-ref a-vector a))
       (equal? (vector-ref a-vector a) (vector-ref a-vector b))
       (equal? (vector-ref a-vector b) (vector-ref a-vector c))))

; Returns the first element of lst that is not empty.
(define (first-not-empty lst)
  (if (empty? lst) empty (if (empty? (first lst)) (first-not-empty (rest lst)) (first lst))))

; Evaluates the game for the specified list of triplets.
;
; Either returns the symbol of the winner or empty if no one won.
(define (game-evaluate-triplets a-game triplet-list)
  (first-not-empty
    (map
      (lambda (triplet)
        (if (three-equal-symbols? (game-state a-game) (first triplet) (second triplet) (third triplet))
          (vector-ref (game-state a-game) (first triplet))
          empty))
      triplet-list)))

; Evaluates the game for results in all valid directions.
;
; Either returns the symbol of the winner or empty if no one won.
(define (game-evaluate a-game)
  (game-evaluate-triplets
    a-game
    (list
      ; Horizontal lines
      (list 0 1 2) (list 3 4 5) (list 6 7 8)
      ; Vertical lines
      (list 0 3 6) (list 1 4 7) (list 2 5 8)
      ; Diagonal lines
      (list 0 4 8) (list 2 4 6))))

; Returns whether or not the game is finished.
(define (game-finished? a-game) (not (empty? (game-evaluate a-game))))

; Stub
(define (solve game)
  (if (game-finished? game)
    game
    (solve (derive-games game))))

(provide game game-evaluate)
