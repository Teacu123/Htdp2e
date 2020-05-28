;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex_31-37) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;34
; String -> String
; Return first character from s
(define (string-first s)
  (string-ith s 0))
(check-expect (string-first "cat") "c")
(check-expect (string-first "lat") "l")

;35
; String -> String
; Return last character from s 
(define (string-last s)
 (string-ith s (- (string-length s) 1)))
(check-expect (string-last "cat") "t")
(check-expect (string-last "no") "o")

;36
; Image -> Number
; Returns image area of img
(define (image-area img)
  (* (image-height img) (image-width img)))
(check-expect (image-area (square 5 "outline" "blue")) 25)
(check-expect (image-area (rectangle 5 4 "outline" "blue")) 20)

;37
; String -> String
; produces remaining string after removing first
; character from s
(define (string-rest s)
  (substring s 1))
(check-expect (string-rest "cat")
              (substring "cat" 1))
(check-expect (string-rest "n")
              (substring "n" 1))