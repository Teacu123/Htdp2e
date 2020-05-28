;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 53-56) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

#|
EXERCISE 53
Examples of LR
If LR is 0 how can we interpret that?
LR represents the distance between the rocket and top of the canvas
so LR 0 means rocket is at the top of the canvas
likewise LR of HEIGHT means rocket is on the ground
|#

;Step 1 form constants
(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
(define TICS-PER-SECOND 10)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

; Step 2 data definition

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

#|
Step 3
Use world program 'wish list' of functions.
each entry should have
a) signature (type of input -> type of output)
b) purpose statement
c) function header

Step 4 Use design recipe for functions
to create complete definitions for all
items on the wishlist. For every function on
the wish list add
a) test cases
b) function body

Be sure that for intervals your test cases
capture the ends and the middle of the intervals


EXERCISE 54
It is inappropriate to use (string=?...)
because this function is mean to compare
wether or not some strings are equal
to one another. Instead, we are interested
in testing if the type of LRCT is a string
which means that the rocket must be resting.
Below, I show an example of a correct boolean
expression that tests wether x belongs to the
first subclass of LRCD

(string? "resting")


EXERCISE 55
Below is a helper function used by show.
The purpose of this function is to draw rocket
onto the background at a given height. It is a good
idea to separate the task of drawing the function
from the task of deciding which height to display
the function at (which is the job of show).
|#

; Number -> Image
; produce an image of a rocket at the given height
(define (draw-rocket height)
  (place-image ROCKET 20 height BACKG))

;LRCD -> Image
; renders the state as a resting or flying rocket 
(define (show x)
  (cond
    [(string? x) (draw-rocket (- HEIGHT CENTER))]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (draw-rocket (- HEIGHT CENTER)))]
    [(>= x 0) (draw-rocket (- x CENTER))]))
 
; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed, 
; if the rocket is still resting 
(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

#|
EXERCISE 56

tic handler can tic 10 times a second instead of 28 times.

(on-tick tick-handler 10) ;10 tics per second

stop when handler ends program before rocket goes back to
0 which would loop it back to the ground.
|#

; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

; LRCD -> Boolean
; true if LRCD is subclass 3 (a number greater equal to 0)
; such that the number is equal to positive 1
(define (stop-rocket? rh)
  (and (number? rh) (= rh 3)))  

; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [stop-when stop-rocket?]
    [on-key launch]))

(define (main2 s)
  (big-bang s
    [to-draw show]
    [stop-when stop-rocket?]
    [on-key launch]
    [on-tick fly]))

(main2 "resting")

