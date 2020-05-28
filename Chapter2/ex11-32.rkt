;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex11-32) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/batch-io)

; this loads an image from the resource folder.
; this will only work if you have the entire
; dropbox folder.
(define belle (bitmap "../assets/belle.png"))

;11
(define (distance-to-origin x y)
  (sqrt (+ (* x x)  (* y y))))

(distance-to-origin 3 4) ; 5

;12
(define (cvolume length)
  (* length length length))
(cvolume 3) ; 27
  
;13
(define (string-first s)
  (string-ith s 0))
(string-first "cat") ;c

;14
(define (string-last s)
  (string-ith s (- (string-length s) 1)))
(string-last "cat")

;15
(define (==> sunny friday)
  (or (not sunny) friday))
(==> #true #false) ; this is the only case that returns false

;16
(define (image-area img)
  (* (image-height img) (image-width img)))
(image-area belle)

;17
(define (classify img)
  (if (< (image-width img) (image-height img)) "tall" "wide"))
(classify (rectangle 20 30 "outline" "blue")) ; tall
(classify (rectangle 30 20 "outline" "blue")) ; wide

;18
(define (string-join s1 s2)
  (string-append s1 "_" s2))
(string-join "cat" "hat")
  
;19
(define (string-insert s i)
  (string-append (substring s 0 i) "_" (substring s i)))
(string-insert "cats" 2) ; ca_ts

;20
; without using an if statement there is no way to
; handle the case of the empty string
(define (string-delete s i)
  (string-append
   (substring s 0 i)
   (substring s (+ i (if (= (string-length s) 0) 0 1)))))
(string-delete "" 0) ; ""
(string-delete "cat" 0) ;at

;27-31
; a reference price. 
(define TICKET-COST 5.0)
; the amount of people that will show up
; if the price of a ticket is TICKET-COST
(define RELATIVE-PEOPLE 120)
(define PRICE-CHANGE 0.10)
(define PEOPLE-CHANGE 15)
; sensitivity represents how sensitive
; a change in price is to a change in people
(define SENSITIVITY (/ PEOPLE-CHANGE PRICE-CHANGE))
; a fixed operating cost of running the theater
(define FIXED-COST 180)
; a variable cost representing how much
; each person who comes to the theater costs
(define VARIABLE-COST .04)
(define (attendees ticket-price)
  (- RELATIVE-PEOPLE
     (* (- ticket-price TICKET-COST) SENSITIVITY)))
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))
(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 2.8)
(profit 2.9) ; this is optimal price to a dime
(profit 3) 

;31
(define (letter fst lst signature-name)
  (string-append
    (opening fst)
    "\n\n"
    (body fst lst)
    "\n\n"
    (closing signature-name)))
 
(define (opening fst)
  (string-append "Dear " fst ","))
 
(define (body fst lst)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))
 
(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))

;first create the appropriate files
(write-file "firstname" "Exotic")
(write-file "lastname" "Joe")
(write-file "signature" "EX JOE")

(main "firstname" "lastname" "signature" 'stdout)

;32
;imagine there is a bio computer that is able to
;monitor the health of each organ in a human body.
;here are some events that the computer might
;need to deal with
;1) heart rate fall dangerously low or rises too high
;the computer should react to this event by calling the
;paramedics
;2) each day at a time decided by the user, a report is
;generated summarizing the users overall health.