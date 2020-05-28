;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex_39_solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;I Physical constants
(define WIDTH-OF-WORLD 500)
(define HEIGHT-OF-WORLD 50)
; Wheel radius is our point of control
; that means simply by changing WHEEL-RADIUS
; we can resize the car.
(define WHEEL-RADIUS 10)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

;II Graphical constants
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
 (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
; defines the width of the car body
; it should be as wide as BOTH-WHEELS
; with a little bit of extra.
(define CAR-BODY-WIDTH
  (* (image-width BOTH-WHEELS) 1.3))
(define CAR-BODY-HEIGHT
  (image-height BOTH-WHEELS))
; the main part of the car (not including roof)
(define CAR-BODY
  (rectangle CAR-BODY-WIDTH CAR-BODY-HEIGHT "solid" "green"))
; the car body will be placed on top of BOTH-WHEELS
; to do that we must offset the y position
; when doing an overlay between BOTH-WHEELS
; and CAR-BODY
(define CAR-BODY-X-OFFSET 0)
; We only want half of the wheels to be showing.
; thus when overlain onto TWO-WHEELS
; CAR-BODY must be shifted shifted half of the height of
; TWO-WHEELS
(define CAR-BODY-Y-OFFSET
  (* (image-height BOTH-WHEELS) .5))

(define CAR-BODY-TWO-WHEELS
  (overlay/offset CAR-BODY
                  CAR-BODY-X-OFFSET
                  CAR-BODY-Y-OFFSET
                  BOTH-WHEELS))
; ROOF-WIDTH is 1/3 of the CAR-BODY
(define ROOF-WIDTH
  (/ (image-width CAR-BODY) 2))
(define ROOF-HEIGHT
  (/ (image-height CAR-BODY) 1.3))

(define ROOF
  (rectangle ROOF-WIDTH ROOF-HEIGHT "solid" "green"))

; finally we define the CAR image. This is what will
; actually get placed onto the window.
(define CAR
  (above ROOF CAR-BODY-TWO-WHEELS))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
CAR


;(2) Develop a data representation for all possible states of
;the world.

; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car


;(3) design a number of functions so that you can form a
;valid big-bang expression.

; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  BACKGROUND)
 
; WorldState -> WorldState
; adds 3 to x to move the car right 
(define (tock x)
  x)


;(4) main function
; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))

(main 0)