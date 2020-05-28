;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex_44_solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(require 2htdp/image)
(require 2htdp/universe)

; Constants
(define WIDTH-OF-WORLD 500)
(define HEIGHT-OF-WORLD 50)
(define WHEEL-RADIUS 5)
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
(define tree
  (overlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 32 "solid" "brown")))
(define BACKGROUND
  (overlay tree
  (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))



; We want the car to have its wheels at the bottom of the background.
; place iamge will put the image onto the scene
; at whatever point you specify. specifically,
; it puts the images center point at the cordinate
(define Y-CAR
  (- HEIGHT-OF-WORLD (/ (image-height CAR) 2)))


; A WorldState is a Number.
; interpretation: the x cordiante of the right-most
; edge of the car


; Replace this with (check-expect statements)
; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
(define (tock ws)
  (+ ws 3))
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)


; Number -> Number
; Given a starting center x of the car
; determine what the cordinate of the right-most
; edge of the car would be
(define (car-right-most-x start-x)
  (+ start-x (/ (image-width CAR) 2)))

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world stat
(define (render ws)
   (place-image CAR
              ws
              Y-CAR
              BACKGROUND))


; Number -> Number
; calculates the left boundary
; for the x cordinate of the car.
; That is, the cordinate of the left
; edge of the rectangle
(define (car-x-left-boundary car-center-x)
  (- car-center-x (/ (image-width CAR) 2)))

(check-expect (car-x-left-boundary 100)
              (- 100 (/ (image-width CAR) 2) ))          
(check-expect (car-x-left-boundary WIDTH-OF-WORLD)
              (- WIDTH-OF-WORLD (/ (image-width CAR) 2)))

; WorldState -> Boolean
; if the entire car is no longer visible on
; rightside of the screen return true
; otherwise return false
(define (car-is-offscreen? ws)
  (> (car-x-left-boundary ws) WIDTH-OF-WORLD))

(check-expect (car-is-offscreen? WIDTH-OF-WORLD)
              (> (car-x-left-boundary WIDTH-OF-WORLD) WIDTH-OF-WORLD))
(check-expect (car-is-offscreen? 100)
              (> (car-x-left-boundary 100) WIDTH-OF-WORLD))
(check-expect (car-is-offscreen? (* WIDTH-OF-WORLD 2))
              (> (car-x-left-boundary  (* WIDTH-OF-WORLD 2)) WIDTH-OF-WORLD))


(check-expect (render 20)
              (place-image CAR 20 Y-CAR BACKGROUND))
(check-expect (render 40)
              (place-image CAR 40 Y-CAR BACKGROUND))


; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down" 
(define (hyper x-position-of-car x-mouse y-mouse me)
  (if (string=? me "button-down") x-mouse x-position-of-car))

(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 41 10 20 "move") 41)
(check-expect (hyper 41 10 20 "button-down") 10)


; WorldState -> WorldState
; launches the program from a starting x
; this x cordinate denotes the desired x
; of where the right edge of the car should start
(define (main starting-x)
   (big-bang  (car-right-most-x starting-x)
     [stop-when car-is-offscreen?]
     [on-tick tock]
     [on-mouse hyper]
     [to-draw render]))

; uncomment if you want to run it
(main 20)