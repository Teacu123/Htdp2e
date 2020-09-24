;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex59-62) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;;
; EXERCISE 60

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume 

(define WIDTH 400)
(define HEIGHT 400)
(define SN (empty-scene WIDTH HEIGHT))
(define RED (bitmap/file "../assets/light-red.png"))
(define GREEN (bitmap/file "../assets/light-green.png"))
(define YELLOW (bitmap/file "../assets/light-yellow.png"))

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(define (tl-next cs) 
    (cond 
     [(string=? "red" cs) "green"]
     [(string=? "green" cs) "yellow"]
     [(string=? "yellow" cs) "red"]))
 
; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render cs)
  (place-image 
    (cond 
     [(string=? "red" cs) RED]
     [(string=? "green" cs) GREEN]
     [(string=? "yellow" cs) YELLOW])
    (/ WIDTH 2)
    (/ HEIGHT 2)
    SN)) 


; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

(make-posn 4 5)
;;
; Exercise 61
; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow

; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

(check-expect (tl-next-numeric 0) (modulo (+ 0 1) 3))
(check-expect (tl-next-numeric 1) (modulo (+ 1 2) 3))
(check-expect (tl-next-numeric 2) (modulo (+ 2 1) 3))

#|
N-TrafficLight data representation is not as good as
the TrafficLight representation. tl-next-numeric
is now more complicated to understand when reading the code.
The informatio being represented is traffic lights. 
Using numbersto represent traffic lights makes for a shorter
tl-next-numeric (since we do not need test cases anymore)
but ultimately it is more difficult to read.

By contrast it is very easy to read the original tl-render.
In this case the lengthy code should be perferred because
of program clarity. One could improve tl-next-numeric
by adding constants such as (define RED 0) which
would make the code a little easier to read.

The next exercise deals with that. Still, I think that
TrafficLight is a better data representation.
|#

;;
;62

(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN

; DoorState -> DoorState
; closes an open door over the period of one tick 
(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN state-of-door) CLOSED]))
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)

; DoorState KeyEvent -> DoorState
; turns key event k into an action on state s
(define (door-action s k)
  (cond
    [(and (string=? LOCKED s) (string=? "u" k))
     CLOSED]
    [(and (string=? CLOSED s) (string=? "l" k))
     LOCKED]
    [(and (string=? CLOSED s) (string=? " " k))
     OPEN]
    [else s]))
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)

; DoorState -> Image
; translates the state s into a large text image
(define (door-render s)
  (text s 40 "red"))
(check-expect (door-render CLOSED)
              (text CLOSED 40 "red"))

; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key door-action]
    [to-draw door-render]))

