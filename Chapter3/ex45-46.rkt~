;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex45-46) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define SN-WIDTH 100)
(define SN-HEIGHT 50)
(define SN-MID-Y (/ SN-HEIGHT 2))
(define SN (empty-scene SN-WIDTH SN-HEIGHT))
; Change in CAT's x each clock tic 
(define CAT-DX 3)

(define CAT (bitmap/file "../assets/ninja_a.png"))
(define CAT-ALT (bitmap/file "../assets/ninja_b.png"))

(define HALF-CAT-WIDTH (/ (image-width CAT) 2))
; the cordinate where the cat would appear of the screen
; this number must be an integer
(define SN-EDGE (ceiling (+ SN-WIDTH HALF-CAT-WIDTH)))

#|
WorldState is a Number
Interpretation
the ws represents the position of the center x of the cat.
this number is always between 0 and SN-WIDTH + HALF-CAT-WIDTH
|#

; Number -> Number
; Calculate the position of the cat based on the previous position
(define (position previous-x)
  (modulo (+ previous-x CAT-DX) SN-EDGE))
(check-expect (position 20) (modulo (+ 20 CAT-DX) SN-EDGE))
(define TEST-OFFSCREEN (+ SN-WIDTH 50))
(check-expect (position  TEST-OFFSCREEN) (modulo (+ TEST-OFFSCREEN CAT-DX) SN-EDGE))
                                    
; Number, Image -> Image
; Places an image onto SN
; at center-x
(define (place-cat cat-x cat-img)
  (place-image cat-img cat-x SN-MID-Y SN))
  

; WorldState -> Image
; cw represents the center position of the cat
(define (render cw)
  (if (odd? cw)
      (place-cat cw CAT-ALT)
      (place-cat cw CAT)))

(check-expect (render 50) (place-cat 50 CAT)) 
(check-expect (render 53) (place-cat 53 CAT-ALT)) 
 
; WorldState -> WorldState
; Each clock tic calculate the cats new position
(define (clock-tick-handler cw) (position cw) )
 
(define (main start-x)
  (big-bang start-x
    [on-tick clock-tick-handler]
    [to-draw render]))

(main 0)



