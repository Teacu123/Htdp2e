;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 50-51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings: 
; – "red" 
; – "green" 
; – "yellow" 
; interpretation the three strings represent the three  
; possible states that a traffic light may assume  

; 50
; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; 51
; LightState is a TrafficLight
; It represents the current state of the traffic light

; Window constants
(define SN-W 500)
(define SN-H 500)
(define SN-CENTER (/ SN-W 2))

; TrafficLight Constants
(define LIGHT-RADIUS 100)

; Graphic constants
(define SN (empty-scene SN-W SN-H))

; TrafficLight -> Image
; Given a traffic light produce an image
; of a circle with fill set to the corresponding color t
(define (draw-traffic-light t)
  (circle LIGHT-RADIUS "solid" t))
(check-expect (draw-traffic-light "green") (circle LIGHT-RADIUS "solid" "green"))
(check-expect (draw-traffic-light "red") (circle LIGHT-RADIUS "solid" "red"))
(check-expect (draw-traffic-light "yellow") (circle LIGHT-RADIUS "solid" "yellow"))

; LightState -> Image
; uses ls to render the scene with a circle
; centered in the middle of the screen
(define (render ls)
  (place-image (draw-traffic-light ls) SN-CENTER SN-CENTER SN))
(check-expect (render "green") (place-image (draw-traffic-light "green") SN-CENTER SN-CENTER SN))
(check-expect (render "red") (place-image (draw-traffic-light "red") SN-CENTER SN-CENTER SN))
(check-expect (render "yellow") (place-image (draw-traffic-light "yellow") SN-CENTER SN-CENTER SN))
 
; LightState -> LightState
; for each tick of the clock, big-bang obtains the next LightState
(define (clock-tick-handler ls)
  (traffic-light-next ls))

(define (main start-color)
  (big-bang start-color
    [on-tick clock-tick-handler]
    [to-draw render]))

(main "green")