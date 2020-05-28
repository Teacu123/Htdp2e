;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;1.
(define x 3)
(define y 4)
(sqrt (+ (* x x) (* y y)))

;2
(define prefix "hello")
(define suffix "world")
(string-append prefix suffix)

;3
(define str "helloworld")
(define i 5)
(string-append (substring str 0 i) "_" (substring str i ))

;4
(string-append (substring str 0 i) (substring str (+ i 1)))

;usually this goes at the top of the file
;it is put here to show you the the remaining
;exercises rely on this module
(require 2htdp/image)

;5
;We want to make it easy to scale the image. All calculations are therefore
;relative to the trunk width

(define TRUNK-WIDTH 10)
(define TRUNK-HEIGHT (* TRUNK-WIDTH 2))
(define LEAF-SCALE 3)
(define trunk-avg (/ (+ TRUNK-WIDTH TRUNK-HEIGHT) 2))
(define trunk (rectangle TRUNK-WIDTH TRUNK-HEIGHT "solid" "brown"))
(define leaf (triangle (*  trunk-avg LEAF-SCALE) "solid" "green"))
(define half-leaf-height (/ (image-height leaf) 2))
(define half-trunk-height (/ (image-height trunk) 2))

#|
since images are alligned at the center points when doing overlay
in order to put the trunk at the bottom of the leaf we must
calculate what half of the height of the leaf is so we can move the
trunk by that much downward. but then half of the trunk will still
be showing so we move the trunk down an additional half of trunk
|#

(overlay/offset leaf (/ (image-width leaf) 2) (+ half-leaf-height half-trunk-height ) trunk)
(define tree (overlay/offset leaf 0 (+ half-leaf-height half-trunk-height ) trunk))
tree

;6
(define cat (bitmap/file "../assets/cat.png"))
(define pixel-count (* (image-height cat) (image-width cat)))
(string-append "The cat is made up of " (number->string pixel-count ) " pixels")

;7
(define sunny #true)
(define friday #false)
(or (not sunny) friday)

;8
(if (< (image-height cat) (image-width cat)) "wide" "tall")
;8.1 tall wide or square
(define tall-rect (rectangle 10 50 "solid" "blue"))
(define wide-rect (rectangle 50 10 "solid" "red"))
(define my-square (square 50 "outline" "purple"))
(define (classify-image img)
  (cond [(< (image-height img) (image-width img)) "wide"]
        [(> (image-height img) (image-width img)) "tall"]
        [else "square"]))

(classify-image tall-rect)
(classify-image wide-rect)
(classify-image my-square)

;9
(define in 3)
;(define in cat)
;(define in 0)
;(define in -10)
;(define in #true)
;(define in #false)
(cond [(string? in) (string-length in)]
      [(image? in) (* (image-width in) (image-height in))]
      [(number? in) (if (<= in 0) in (- in 1))]
      [(boolean? in) (if in 10 20)])