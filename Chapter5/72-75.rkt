;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 72-75) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;72a
(define-struct phone [area number])
; a Phone is a structure
; (make-phone Number Number)
; interpretation (make-phone area number) means
; a phone number with a three digit area code and
; 7 digit number.

;72b
(define-struct phone# [area switch num])
;a Phone# is a structure
; (make-phone# Number Number Number)
; interpretation (make-phone# area switch num)
; represents a phone number
; area is a three digit number
; switch is a three digit number
; num is a four digit number

;74
; Posn, Number -> Posn
; produce a posn similar to p but with n in the x field
(define (posn-up-x p n)
  (make-posn n (posn-y p)))
;testing
(define test-1 (make-posn 10 3))
(check-expect (posn-up-x test-1 2)
              (make-posn 2 (posn-y test-1)))

; Posn -> Posn
; increases the x-coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(define (x+ p)
  (posn-up-x p (+ 3 (posn-x p))))

;74
(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
; A Posn represents the state of the world.

; Posn -> Image
; adds a red spot to MTS at p
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

; Posn Number Number MouseEvt -> Posn 
; for mouse clicks, (make-posn x y); otherwise p
(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))

; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

(main (make-posn 50 50))

;75
