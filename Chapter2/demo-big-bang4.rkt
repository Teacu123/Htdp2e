;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname move_ball) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define W 720)
(define H 405)
(define BG (empty-scene W H))
(define BALL (circle 50 "solid" "red"))
(place-image BALL 300 200 BG)
(define CENTER-X (/ W 2))
(define CENTER-Y (/ H 2))

(define (change y ke)
  (cond
    [(key=? ke "up")  (- y 10)]
    [(key=? ke "down") (+ y 10)]
    [else y]))

(define (place-ball-at y)
  (place-image BALL CENTER-X y BG))

(big-bang CENTER-Y
  [to-draw place-ball-at]
  [on-key change])

