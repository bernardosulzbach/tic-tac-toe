#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require "tic-tac-toe.rkt")

(define window-side 600)
(define default-line-color 'Maroon)

(define (process-mouse world-state x y event)
  (when (equal? event "button-down") (displayln (format "(~a, ~a)" x y)))
  world-state)

(define (draw-vertical-line scene x)
  (add-line scene x 0 x window-side default-line-color))

(define (draw-horizontal-line scene y)
  (add-line scene 0 y window-side y default-line-color))

(define (empty-board)
  ((compose
     (lambda (scene) (draw-vertical-line scene (/ window-side 3)))
     (lambda (scene) (draw-vertical-line scene (* 2 (/ window-side 3))))
     (lambda (scene) (draw-horizontal-line scene (/ window-side 3)))
     (lambda (scene) (draw-horizontal-line scene (* 2 (/ window-side 3))))) (empty-scene window-side window-side)))

(define (draw-game world-state)
  (empty-board))

(big-bang (make-empty-game)
          (name "Tic-tac-toe")
          (on-mouse process-mouse)
          (to-draw draw-game))
