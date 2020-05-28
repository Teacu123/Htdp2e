;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex_40_solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
If you could not solve 39 you can use this code
to work on exercise 40.
|#

(require 2htdp/image)
(require 2htdp/universe)

; Constants
(define WIDTH-OF-WORLD 500)
(define HEIGHT-OF-WORLD 50)
(define WHEEL-RADIUS 10)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
 (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR-BODY-WIDTH
  (* (image-width BOTH-WHEELS) 1.3))
(define CAR-BODY-HEIGHT
  (image-height BOTH-WHEELS))
(define CAR-BODY
  (rectangle CAR-BODY-WIDTH CAR-BODY-HEIGHT "solid" "green"))
(define CAR-BODY-X-OFFSET 0)
(define CAR-BODY-Y-OFFSET
  (* (image-height BOTH-WHEELS) .5))
(define CAR-BODY-TWO-WHEELS
  (overlay/offset CAR-BODY
                  CAR-BODY-X-OFFSET
                  CAR-BODY-Y-OFFSET
                  BOTH-WHEELS))
(define ROOF-WIDTH
  (/ (image-width CAR-BODY) 2))
(define ROOF-HEIGHT
  (/ (image-height CAR-BODY) 1.3))
(define ROOF
  (rectangle ROOF-WIDTH ROOF-HEIGHT "solid" "green"))
(define CAR
  (above ROOF CAR-BODY-TWO-WHEELS))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))


; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car


; Replace this with (check-expect statements)
; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
(define (tock ws)
  (+ ws 3))
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  BACKGROUND)


; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))


(main 0)