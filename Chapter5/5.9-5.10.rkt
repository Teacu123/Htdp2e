;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.9-5.10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
5.9
Ufo descends vertically on line.
Tank moves horizontall at the bottom of the screen.

structure type definition
- field for each property
- what type of data goes into each field
- data examples
|#
(define-struct space-game [ufo tank])
; A Space-Game is a structure
; ufo is the y coordinate of the ufo
; tank is x coordinate of the tank
; (make-space-game Number Number)

(define g1 (make-space-game 20 50))
; lets access the values
(space-game-ufo g1)
(space-game-tank g1)
(space-game? g1) ;#true
(space-game? 10) ;#false

; Now lets say that the ufo is able to move along the x and y axis.
; Suppose the tank is still limited only to the x axis.
; This means we redefine the struct so that the first field (ufo)
; is represented by a Posn
(define-struct space-game1 [ufo tank])
; A SpaceGame is a structure:
;(make-space-game1 Posn Number)
; interpretation (make-space-game (make-posn ux uy) tx)
; describes a configuration where the UFO is 
; at (ux,uy) and the tank's x-coordinate is tx

