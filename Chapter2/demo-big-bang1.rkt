;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname big-bang-demo) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)

(define (number->square s)
  (square s "solid" "red"))

(define (reset s ke) 100)

(big-bang 100
  [to-draw number->square]
  [on-tick sub1]
  [stop-when zero?]
  [on-key reset])

#|
we now consider how big-bang produces each state.

assume the following three events are to be
processed

1. user presses 'a'
2. clock ticks
3. clock ticks

Remember, big bang can
1) draw an image
2) given an event and the current state it can produce
the next state

big band always starts with an inital state in this case assume
that initial state is 100
|#

(define cw0 100)
; user presses 'a'
(define cw1 (reset cw0 "a"))
;clock ticks
(define cw2 (sub1 cw1))
;clock ticks
(define cw3 (sub1 cw2))

(big-bang 100 [to-draw number->square])
(big-bang cw3 [to-draw number->square])