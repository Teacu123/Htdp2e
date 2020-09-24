;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |78|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 78

(define-struct word [c1 c2 c3])
; A Word is a structure
;    (make-word 1String 1String)
; interpretation (make-word c1 c2 c3)
; is a 3 letter words with the characters c1 c2 c3

(word-c1 (make-word "d" "o" "g")) ; should give us d