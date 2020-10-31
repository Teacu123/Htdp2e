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
(define DELUFO 5)
(define TANK-DX 4)
(define DELMIS (* DELUFO 3))
(define BG-POS (make-posn 0 0))
(define TANK-Y 380)



;Structures

; Enemy constants (ufo in book)
(define ENEMY
 (bitmap/file "../assets/asteroid.gif"))
; Hero constants (tank in book)
(define TANK
  (scale 0.5
    (bitmap/file "../assets/spacetank.png")))
(define MISSILE
  (rectangle 5 10 "solid" "yellow"))
(define BOOM
  (scale 0.2
   (bitmap/file "boom.png")))

; A Enenmy is a Posn.  
; interpretation (make-posn x y) is the Enemy's location  
; (using the top-down, left-to-right convention) 
(define E1 (make-posn (-(/ W 2)(/(image-width ENEMY)2)) 0))
; A Tank is a structure: 
;   (make-hero Number Number).  
; interpretation (make-hero x dx) specifies the position: 
; (x, HEIGHT) and the tank's speed: dx pixels/tick
 (define-struct tank [loc vel])
 (define H1 (make-tank (-(/ W 2)(/(image-width TANK)2)) TANK-DX))

; A Missile is a Posn.  
; interpretation (make-posn x y) is the missile's place
 (define M1 (make-posn (-(/ W 2)(/(image-width TANK)2)) 200))

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])



; colission threshold
(define C (- (/ (image-width ENEMY) 2) 14))

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game


  


;testcases example
(define aim1 (make-aim E1 H1))
(define fired1 (make-fired (make-posn 0 0) (make-tank 100 TANK-DX) (make-posn 100 100)))
(define start (make-aim E1 H1))
;SIG -> Image
;Get the location of each object, and render to the Background.
;(define (render sig)
 ; (cond
  ;  [(aim? sig)
   ;  (place-images/align
    ;  (list ENEMY TANK BG)
     ; (list (aim-ufo sig)
      ;      (make-posn (tank-loc(aim-tank sig)) 380)
       ;     BG-POS)
     ; "left"
     ; "top"
     ;  SN)]
    ;[(fired? sig)
     ;(place-images/align
      ;(list ENEMY TANK MISSILE BG)
      ;(list (fired-ufo sig)
            ;(make-posn (tank-loc(fired-tank sig)) 380)
            ;(fired-missile sig)
            ;BG-POS)
      ;"left"
      ;"top"
      ;SN)]))





; Tank Image -> Image 
; adds t to the given image im
(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))
;(tank-render H1 BG)
 
; UFO Image -> Image 
; adds u to the given image im
(define (ufo-render u im)
  (place-image ENEMY (posn-x u) (posn-y u) im))
(check-expect (ufo-render E1 BG)
              (place-image ENEMY (posn-x E1) (posn-y E1) BG))

; Missile Image -> Image 
; adds m to the given image im
(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))
;(missile-render M1 BG)

; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 36
(define (render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BG))]
    [(fired? s)
     (tank-render
       (fired-tank s)
       (ufo-render (fired-ufo s)
                   (missile-render (fired-missile s)
                                   BG)))]))


; UFO -> UFO
(define (move-ufo-down ufo)
  (make-posn (posn-x ufo) (+ (posn-y ufo) DELUFO)))

(check-expect (move-ufo-down E1)
              (make-posn (posn-x E1) (+ (posn-y E1) DELUFO)))

;SIGS -> Boolean  
; return #true if UFO is at the bottom of the screen
(define (at-bottom? sigs)
  (cond
    [(aim? sigs)(>= (posn-y(aim-ufo sigs)) H)]
    [(fired? sigs)(>= (posn-y(fired-ufo sigs)) H)]))

 ;(check-expect (at-bottom? E1)
  ;              (>= (posn-y E1) H))
;(define EBOT (make-posn 0 H))
 ;(check-expect (at-bottom? EBOT)
  ;              (>= (posn-y EBOT) H))
 ;(check-expect (at-bottom? (move-ufo-down EBOT))
   ;             (>= (posn-y (move-ufo-down EBOT)) H))

;SIGS -> Boolean
;Check ufo reached at the bottom or missile hit to ufo,
;then return true when it's true 
(define (si-game-over sig)
  (cond
    [(aim? sig) (at-bottom? sig)]
    [(fired? sig)
      (or
       (collision? (distance
                      (posn-x(fired-ufo sig))
                      (posn-y(fired-ufo sig))
                      (posn-x(fired-missile sig))
                      (posn-y(fired-missile sig))))
       (at-bottom? sig))]))

;SIGS -> image
;show end scene
(define (last-scene sig)
  (place-image BOOM (posn-x (fired-ufo sig)) (posn-y(fired-ufo sig)) (render sig)))
(last-scene fired1)

; examples
;(0,0), (5,5)
; x1, y1, x2,y2
(define (distance x1 y1 x2 y2)
   (inexact->exact (sqrt (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2)))))
  

(check-expect (distance 0 0 5 5)
              (inexact->exact (sqrt (+ (expt (- 5 0) 2) (expt (- 5 0) 2)))))

; Number -> Boolean
(define (collision? distance)
   (<= distance C))
  

;(check-expect (collison? 30)
 ;             (<= 30 C))
;(check-expect (collison? C)
 ;             (not(<= (+ C 1) C)))
;SIGS -> SIGS
;Compute the move of sigs and make new sigs which is added the moves
(define (si-move sig)
  (cond
    [(aim? sig) (make-aim
                 (make-posn (posn-x(aim-ufo sig))(+ (posn-y(aim-ufo sig)) DELUFO))
                 (aim-tank sig))]
    [(fired? sig) (make-fired (make-posn (posn-x(fired-ufo sig)) (+ (posn-y(fired-ufo sig))DELUFO))
                              (fired-tank sig)
                              (make-posn (posn-x(fired-missile sig))(- (posn-y(fired-missile sig))DELMIS)))]))

;SIGS->TANK
;Make new SIGS which is computed moves of tank
(define (tank-move-left sig)
  (cond
    [(aim? sig)(-(tank-loc(aim-tank sig))
                 (tank-vel(aim-tank sig)))]
    [(fired? sig)(-(tank-loc(fired-tank sig))
                 (tank-vel(fired-tank sig)))]))
(define (tank-move-right sig)
  (cond
    [(aim? sig)(+(tank-loc(aim-tank sig))
                 (tank-vel(aim-tank sig)))]
    [(fired? sig)(+(tank-loc(fired-tank sig))
                 (tank-vel(fired-tank sig)))]))

;Problem Analysis & Data Definition
;Contract, Purpose & Effect Statements, Header
;Examples
;Function Template
;Function Definition
;Tests

;SIGS, Key->SIGS
(define (si-onkey sig key)
  (cond
    [(string=? key "left")
     (cond
       [(aim? sig)(make-aim (aim-ufo sig) (make-tank (tank-move-left sig) TANK-DX))]
       [(fired? sig)(make-fired (fired-ufo sig) (make-tank (tank-move-left sig) TANK-DX) (fired-missile sig))])]
    [(string=? key "right")
     (cond
       [(aim? sig)(make-aim (aim-ufo sig) (make-tank (tank-move-right sig) TANK-DX))]
       [(fired? sig)(make-fired (fired-ufo sig) (make-tank (tank-move-right sig) TANK-DX) (fired-missile sig))])]
    [(string=? key " ")
     (cond
       [(aim? sig)(make-fired (aim-ufo sig) (aim-tank sig) (make-posn (tank-loc(aim-tank sig)) TANK-Y))]
       [(fired? sig)sig])]
    [else sig]))


(define(main sig)
  (big-bang sig
    [on-tick si-move]
    [to-draw render]
    [on-key si-onkey]
    [stop-when si-game-over last-scene]))

(main start)

; distance  x1 x2 y1 y2 -> NUmber

; collision? : Number Number -> True
; collision d K
; d is the distance between the two objects
; K is the collision threshold. d < K is collisons d >=k is not


