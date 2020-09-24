;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname UFO) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
 (bitmap/url "https://www.bootstrapworld.org/clipart/Things/asteroid.gif"))
  
; Hero constants (tank in book)
(define HERO
  (scale 0.5
         (bitmap/url "https://www.bootstrapworld.org/clipart/Vehicles/spacetank.png")))

(place-images
   (list HERO ENEMY BG)
   (list
    (make-posn 250 400)
    (make-posn 250 250)
    (make-posn (/ W 2) (/ H 2)))
   SN)