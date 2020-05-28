;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |47|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)



(define MAX-HAPPY 100)
(define D-ARROW-INCREASE 1/5)
(define U-ARROW-INCREASE 1/3)
(define TIC-DECREASE 0.01) 

(define SN-H 100)
(define SN-W 400)
(define SN (empty-scene SN-W SN-H))


(define GAUGE-HEIGHT (* (image-width SN) .25))
(define GAUGE-PEN (pen "red" 3 "solid" "round" "bevel"))


(define (calc-gauge-width level)
  (* (/ level 100) SN-W))

(define (gauge happy-level)
  (if (= happy-level 0)
      empty-image
      (rectangle (calc-gauge-width happy-level) GAUGE-HEIGHT "outline" GAUGE-PEN)))


(define (key-handler cw ke)
  (cond
    [(key=? ke "up") (+ cw (* cw U-ARROW-INCREASE))]
    [(key=? ke "down") (+ cw (* cw D-ARROW-INCREASE))]
    [else cw]
  ))

(define (tick-handler cw)
  (- cw (* cw TIC-DECREASE))
  )


(define (render cw)
  (place-image/align (gauge cw) 0 (/ SN-H 2) "left" "center" SN))



; WorldState -> Number
; Interpretation, the world state
; represents the current happiness level
; a level of 100 percent indicates maximum happiness
; 0 is lowest

(define (main happy-level)
  (big-bang happy-level
    [to-draw render]
    [on-tick tick-handler]
    [on-key key-handler]))

(main 100)