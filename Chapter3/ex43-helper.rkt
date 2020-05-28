;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex_43_helper) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; The purpose of this file is to help you
; solve number 43 which is quite challenging
; if you have never taken triginometry.
; If you can understand this file you should
; be able to solve #43

(require 2htdp/image)
(require 2htdp/universe)

; constants related to window
(define BG-WIDTH 320)
(define BG-HEIGHT 240)
(define BG-MIDDLE-Y (/ BG-HEIGHT 2))
(define SCENE (empty-scene BG-WIDTH BG-HEIGHT))
;Pen is used to draw a line in the middle
(define PEN (pen "black" 5 "solid" "round" "bevel"))
(define BG (add-line SCENE 0 BG-MIDDLE-Y BG-WIDTH BG-MIDDLE-Y PEN))

; constants related to the ball
(define BALL (circle 10 "solid" "blue"))
(define BALL-SPEED 1/2)
;what is the highest y cordinate that the ball should ever reach?
;this number should never exceed the height of the window
(define BALL-PEAK-HEIGHT 50)

; the sin function takes the number of radians as an argument
; this function converts degrees to radians
(define (degree->radians d)
  (* d (/ pi 180)))

(define (distance time)
  (* time BALL-SPEED))

; Number -> Number
; given the time that has elapsed since the animation started
; return what height the ball should be at
; we must ensure that 
(define (height time)
  (+ BG-MIDDLE-Y (* BALL-PEAK-HEIGHT  (sin (degree->radians time)))))
        
(define (float time)
  (place-image BALL (distance time) (height time) BG))


(animate float)