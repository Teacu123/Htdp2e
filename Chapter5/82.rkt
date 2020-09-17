;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |82|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 82

; A Letter is either 1String or a Boolean

(define-struct word [c1 c2 c3])
; A Word is a structure
;    (make-word Letter Letter)
; interpretation (make-word c1 c2 c3)
; is a 3 letter words with the characters c1 c2 c3

(define w1 (make-word "d" "o" "g"))
(define w2 (make-word "t" "o" "m"))
(define w3 w1)

;  String -> Letter
(define (letter-check l1 l2)
  (if (string=? l1 l2)
      l1
     #false))
(check-expect (letter-check "c" "d")
              (if (string=? "c" "d") "c" #false))
(check-expect (letter-check "c" "c")
              (if (string=? "c" "c") "c" #false))
              

; Word Word -> Word
(define (compare-word w1 w2)
               (make-word (letter-check (word-c1 w1) (word-c1 w2))
                         (letter-check (word-c2 w1) (word-c2 w2))
                         (letter-check (word-c3 w1) (word-c2 w2))))
  
(check-expect (compare-word w1 w2)
              (make-word (letter-check (word-c1 w1) (word-c1 w2))
                         (letter-check (word-c2 w1) (word-c2 w2))
                         (letter-check (word-c3 w1) (word-c2 w2))))
(check-expect (compare-word w1 w3)
              (make-word (letter-check (word-c1 w1) (word-c1 w3))
                         (letter-check (word-c2 w1) (word-c2 w3))
                         (letter-check (word-c3 w1) (word-c2 w3))))
(check-expect (compare-word w1 w1)
              (make-word (letter-check (word-c1 w1) (word-c1 w1))
                         (letter-check (word-c2 w1) (word-c2 w1))
                         (letter-check (word-c3 w1) (word-c2 w1))))
(check-expect (compare-word w3 w2)
              (make-word (letter-check (word-c1 w3) (word-c1 w2))
                         (letter-check (word-c2 w3) (word-c2 w2))
                         (letter-check (word-c3 w3) (word-c2 w2))))
            

(define-struct s [f1 x])

(make-s compare-world "cat")
