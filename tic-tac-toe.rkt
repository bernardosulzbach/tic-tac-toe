; This module contains a minimax implementation for the tic-tac-toe game.
;
; There are functions which can map a game to a score (based on all the
; possible outcomes of that game at the current state).
;
; Other functions will simulate movements by selecting whichever move produces
; the best game.
#lang racket

(define tie-score 0.0)
(define pos-score 100.0)
(define neg-score -100.0)

(define X-symb 'X)
(define O-symb 'O)
(define tie-symb 'T)

(struct game [state] #:transparent)

; Creates and returns an empty game.
(define (make-empty-game)
  (game (make-vector 9 empty)))

; Converts a game to a human-readable string.
;
; This string has two newline characters on it.
(define (game-to-string a-game)
  (apply format "~a ~a ~a\n~a ~a ~a\n~a ~a ~a" (map (lambda (s) (if (empty? s) " " s)) (vector->list (game-state a-game)))))

(define (game-play-less-than? a b)
  (cond
    [(and (empty? a) (empty? b)) false]
    [(empty? a) true]
    [(empty? b) false]
    [else (symbol<? a b)]))

; Compares two games.
(define (game-less-than? a b)
  (andmap game-play-less-than? (vector->list (game-state a)) (vector->list (game-state b))))

; Counts how many times the specified symbol has played in the game.
(define (count-plays a-game symb)
  (vector-count (lambda (s) (equal? s symb)) (game-state a-game)))

; Determines the next player to play in the game.
(define (determine-next-to-play a-game)
  (if (> (count-plays a-game X-symb) (count-plays a-game O-symb)) O-symb X-symb))

; Makes a copy of the input vector and replaces the element at pos by v before returning it.
(define (vector-copy-and-replace vec pos v)
  (vector-append (vector-take vec pos) (vector v) (vector-drop vec (+ pos 1))))

(define (game-after-replacing a-game symb pos)
  (game (vector-copy-and-replace (game-state a-game) pos symb)))

(define (list-games-after-replacing a-game symb pos-list)
  (map (lambda (i) (game-after-replacing a-game symb i)) pos-list))

(define (derive-games-for-player a-game symb)
  (list-games-after-replacing a-game symb (filter (lambda (i) (empty? (vector-ref (game-state a-game) i))) (range 9))))

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

; Returns the first element of lst that is not empty or empty if such element does not exist.
(define (first-not-empty lst)
  (if (empty? lst)
    empty
    (if (empty? (first lst))
      (first-not-empty (rest lst))
      (first lst))))

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

; Evaluates the arithmetic mean of a list of numbers.
(define (list-mean list-of-numbers)
  (if (empty? list-of-numbers) 0 (/ (apply + list-of-numbers) (length list-of-numbers))))

; Evaluates the score of the player in the game.
;
; The bigger this number is, the better the player is in the game.
(define (calculate-game-score a-game player)
  (let
    ([evaluation (game-evaluate a-game)])
    (cond
      [(equal? evaluation player) pos-score]
      [(equal? evaluation tie-symb) tie-score]
      [(empty? evaluation) (list-mean (map (lambda (g) (calculate-game-score g player)) (derive-games a-game)))]
      [else neg-score])))

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

(define (game-won? a-game)
  (not (empty? (game-evaluate a-game))))

(define (game-full? a-game)
  (zero? (vector-count empty? (game-state a-game))))

; Returns whether or not the game is finished.
(define (game-finished? a-game)
  ; For the game to be finished, there must be a winner or no more moves left.
  (or (game-won? a-game) (game-full? a-game)))

; (play Game) -> Game
;
; Plays optimally for the player who is going to play next in the game.
(define (play a-game)
  (if (not (game-finished? a-game))
    ; Return the derived game with the highest score
    (argmax (lambda (g) (calculate-game-score g (determine-next-to-play a-game))) (derive-games a-game))
    a-game))

; (solve Game) -> Game
;
; Solves the provided Game. This results either in a draw or a victory for
; whichever player had an advantage in the game.
(define (solve a-game)
  (if (game-finished? a-game)
    a-game
    (solve (play a-game))))

(provide game
         make-empty-game
         game-to-string
         game-state
         vector-copy-and-replace
         game-evaluate
         game-less-than?
         game-finished?
         play
         solve)
