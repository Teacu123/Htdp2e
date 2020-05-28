;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 48-49) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))

;48
(reward 18) ;produces silver

;49
(define y 3)
(- 200 (cond [(> y 200) 0] [else y])) ;

(define WIDTH  100)
(define HEIGHT  60)
(define MTSCN  (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap/file "../assets/rocket.png"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

;50
(define (create-rocket-scene.v5 h)
  (if (<= h ROCKET-CENTER-TO-TOP)
   (place-image ROCKET 50 h MTSCN)
   (place-image ROCKET 50 ROCKET-CENTER-TO-TOP MTSCN)))

(create-rocket-scene.v5 10)