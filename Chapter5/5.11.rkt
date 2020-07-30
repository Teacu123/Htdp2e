;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |5.11|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;5.11 More virtual pets
(require 2htdp/universe)
(require 2htdp/image)

;;; 88
(define-struct cat [cx ch])
; A Cat is a struct
; cx is the x coordinate of the cat
; ch is happiness level of the cat
; (make-cat Number Number)
;  (make-cat 100 20)

;;; 89
; CatState (cs) is a world
; interpretation is not needed here because
; we already said what a Cat was on problem 88.
; Here we are simply making it clear that
; the world state will be represented by a Cat

;; Constants
(define SN-WIDTH 420)
(define SN-HEIGHT 320)
(define SN-MID-Y (/ SN-HEIGHT 2))
(define SN-MID-X (/ SN-WIDTH 2))
(define SN (empty-scene SN-WIDTH SN-HEIGHT))
;; Constants related to the cat
(define CAT-DX (* 0.05 SN-WIDTH))
(define CAT (bitmap/file "../assets/ninja_a.png"))
(define CAT-ALT (bitmap/file "../assets/ninja_b.png"))
; The cat is anchored at the bottom of the screen
; this number is how much to shift the cat up by
(define CAT-SHIFT-Y (- SN-HEIGHT (/ (image-height CAT) 2)))
; the cordinate where the cat would appear off the screen
(define SN-EDGE (ceiling (+ SN-WIDTH (/ (image-width CAT) 2))))
;; Constants related to the bar
; The bar is anchored on the left side of the screen
; when we do place image we must shift the bar this amount
(define BAR-SHIFT-X (/ SN-WIDTH 2))
(define BAR-HEIGHT (/ SN-HEIGHT 4))
(define HDECREASE .33)
(define SMHAPPY 1/3)
(define LGHAPPY 1/5)
; max happiness amount is 100
(define BAR-SCALE (/ SN-WIDTH 100))

;; Functions related to the cat

; Number -> Number
; Calculate the next x coordinate that the cat will go to
(define (calc-next-cat-x cat-current-x)
  (modulo (+ cat-current-x CAT-DX) SN-EDGE))

; CatState -> Image
; use the cats locations to determine
; which cat sprite to use
(define (render-cat cs)
  (if (odd? (cat-cx cs)) CAT-ALT CAT))

; CatState -> Image
; places the cat onto the empty scene
; this is an intermediate image
; that will later be combined with the
; progress bar
(define (place-cat-on-scene cs)
  (place-image/align (render-cat cs)
                                 (cat-cx cs)
                                 CAT-SHIFT-Y
                                 "center"
                                 "bottom"
                                 SN))

;; Functions related to the bar

; CatState -> Image
(define (render-happy-bar cs)
  (rectangle (calculate-happy-bar-width (cat-ch cs)) BAR-HEIGHT "solid" "red"))

; Number -> Number
; function to determine the appropriate width of the bar
; based on the level of happiness hs
(define (calculate-happy-bar-width hs)
  (* hs (/ SN-WIDTH 100)))

(check-expect (calculate-happy-bar-width 100)
              (* 100 (/ SN-WIDTH 100)))

; HappyState -> Number
; purpose: decreases until bar's width = 0, increases when up or down arrow is pressed
(define (calc-next-cat-h hs)
  (if (> hs 0) (- hs (* hs HDECREASE)) 0))

(define (increase-happy hs key)
  (cond
    [(key=? key "up")    (+ hs (* hs SMHAPPY))]
    [(key=? key "down")  (+ hs (* hs LGHAPPY))]))             


;; Handlers


; CatState -> CatState
; Each clock tick update the x position of the cat
; The happiness level of the cat should decrease
(define (clock-tick-handler cs)
  (make-cat (calc-next-cat-x (cat-cx cs))
            (calc-next-cat-h (cat-ch cs))))


; CatState -> Image
; place the happy bar onto a scene that already has a cat on it
; **better way to do this is to use place images but we have not
; yet learned about lists
(define (render cs)
  (place-image/align (render-happy-bar cs) 0 0 "left" "top" (place-cat-on-scene cs)))

;;Testing
(define c1 (make-cat 200 20))
(define c2 (make-cat 1 0))
(define happy-cat (make-cat 0 100))
(define cat-past-edge (make-cat (+ 50 SN-EDGE) 0))

(check-expect (calc-next-cat-x (cat-cx c1))
              (modulo (+ (cat-cx c1) CAT-DX) SN-EDGE))

(check-expect (place-cat-on-scene c1)
              (place-image/align (render-cat c1)
                                 (cat-cx c1)
                                 CAT-SHIFT-Y
                                 "center"
                                 "bottom"
                                 SN))
(check-expect (place-cat-on-scene c2)
              (place-image/align (render-cat c2)
                                 (cat-cx c2)
                                 CAT-SHIFT-Y
                                 "center"
                                 "bottom"
                                 SN))
(check-expect (render c1)
              (place-image/align (render-happy-bar c1) 0 0 "left" "top" (place-cat-on-scene c1)))

;;Main
(define (main cs0)
  (big-bang cs0
    [on-tick clock-tick-handler 1]
    [to-draw render]))
(main (make-cat 0 100))