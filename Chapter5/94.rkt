;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |94|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;94
(require 2htdp/image)
(require 2htdp/universe)
; Canvas constants
(define BG (bitmap/url "https://www.bootstrapworld.org/clipart/Backgrounds/Space.jpg"))
(define W (image-width BG))
(define H (image-height BG))
(define SN (empty-scene W H))
; Enemy constants (ufo in book)
(define ENEMY
 (bitmap/file "../assets/asteroid.gif"))
; Hero constants (tank in book)
(define HERO
  (scale 0.5
         (bitmap/file "../assets/spacetank.png")))
(define HERO-DX 4)
; A Enenmy is a Posn.  
; interpretation (make-posn x y) is the Enemy's location  
; (using the top-down, left-to-right convention) 
(define e1 (make-posn (/ W 2) (/ H 2)))
(define-struct hero [loc vel]) 
; A Hero is a structure: 
;   (make-hero Number Number).  
; interpretation (make-hero x dx) specifies the position: 
; (x, HEIGHT) and the tank's speed: dx pixels/tick
(define h1 (make-hero (/ W 2) HERO-DX)) 
; A Missile is a Posn.  
; interpretation (make-posn x y) is the missile's place
(define m1 (make-posn (/ W 2) (/ H 2)))
(place-images
   (list HERO ENEMY BG)
   (list
    (make-posn 250 400)
    (make-posn 250 250)
    (make-posn (/ W 2) (/ H 2)))
   SN)
