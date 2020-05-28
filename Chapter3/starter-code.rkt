;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname starter-code) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; This is the starter code for the chapter 3
; world program exercises.
; The program has been broken up into section to
; illustrate the design recipe applied to world programs.


(require 2htdp/image)
(require 2htdp/universe)

;(1)
;I Physical constants
(define WIDTH-OF-WORLD 500)
(define HEIGHT-OF-WORLD 50)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))


;II Graphical constants

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
;(define SPACE
; (rectangle ... WHEEL-RADIUS ... "white"))
;(define BOTH-WHEELS
;  (beside WHEEL SPACE WHEEL))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))



;(2)

; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car

;(3)

; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  BACKGROUND)
 
; WorldState -> WorldState
; adds 3 to x to move the car right 
(define (tock x)
  x)

;(4)
; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))

; uncomment if you want to run it
;(main 0)