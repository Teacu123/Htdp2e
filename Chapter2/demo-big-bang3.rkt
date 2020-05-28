;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname led) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define COLOR-1 "red")
(define COLOR-2 "blue")

; String -> Image
; make an led of the given color
(define (make-led color)
  (circle 100 "solid" color))
(check-expect (make-led "blue") (circle 100 "solid" "blue"))

; World State -> Image
(define (draw-led state)
  (make-led (if state COLOR-1 COLOR-2)))
(check-expect (draw-led #true) (make-led COLOR-1))

; World State is a Boolean

; Worldstate -> Boolean
(define (flip-led state)
  (not state))

(define cw0 #true)


(big-bang cw0
    [to-draw draw-led]
    [on-tick flip-led]
)