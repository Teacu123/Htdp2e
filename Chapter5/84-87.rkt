;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 5.10-part2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; String -> String
; joins two strings together separated by vertical bar
(define (string-join s1 s2)
  (string-append s1 "|" s2))
; String -> 1String
(define (string-first s)
  (if (= (string-length s) 0) "" (string-ith s 0)))
; String -> 1String
(define (string-last s)
 (if (= (string-length s) 0) "" (string-ith s (- (string-length s) 1))))
; String, Int -> String
(define (string-delete s i)
  (string-append
   (substring s 0 (max i 0))
   (substring s (min (+ i 1) (string-length s)))))
; String -> String
; removes first character from string
(define (string-remove-first s)
  (string-delete s 0))
; String -> String
; remove the last character from a string
(define (string-remove-last s)
  (string-delete s (- (string-length s) 1)))
; Editor -> Editor
(define (handle-backspace e)
  (make-editor (string-remove-last (editor-pre e)) (editor-post e)))
; Editor, 1String -> Editor
; returns new editor with chr appended to pre
(define (handle-character e chr)
  (make-editor (string-append (editor-pre e) chr) (editor-post e)))
; 1String -> Boolean
; true if s is either a number of a-zA-Z
(define (is-legal-character? s)
  (and
   (= (string-length s) 1)
   (or (string=? " " s) (string-alphabetic? s) (string-numeric? s))))
; Editor -> Editor
; updates pre and post when left arrow is pressed
(define (handle-left e)
  (make-editor (string-remove-last (editor-pre e))
               (string-append (string-last (editor-pre e)) (editor-post e))))
; Editor -> Editor
(define (handle-right e)
  (make-editor (string-append (editor-pre e) (string-first (editor-post e)))
               (string-remove-first (editor-post e))))
; Editor, KeyEvent-> Editor
; update editor depending on the key event
(define (edit e ke)
  (cond [(string=? ke "\b") (handle-backspace e)]
        [(string=? ke "left") (handle-left e)]
        [(string=? ke "right") (handle-right e)]
        [(is-legal-character? ke) (handle-character e ke)]
        [else e]))
; String -> Image
(define (render-text s)
  (text s 11 "black"))
; Editor -> Image
; Renders the text element with a cursor separating pre and post
(define (editor->image e)
  (beside  (render-text (editor-pre e)) (text "|" 20 "red") (render-text (editor-post e))))
(define (render e)
  (overlay/align "left" "center" (editor->image e) (empty-scene 200 20)))
;;;
; main function
(define (run start-text)
  (big-bang (make-editor start-text "")
    [to-draw render]
    [on-key edit]))
(run "")
;;;
; Test cases
(define e1 (make-editor "eds" "s"))
(define e2 (make-editor "cats" ""))
(define e3 (make-editor "" "dogs"))
(define e4 (make-editor "" ""))
; Test backspace
(check-expect (handle-backspace e1)
              (make-editor (string-remove-last (editor-pre e1)) (editor-post e1)))
(check-expect (handle-backspace e2)
              (make-editor (string-remove-last (editor-pre e2)) (editor-post e2)))
(check-expect (handle-backspace e3)
              (make-editor (string-remove-last (editor-pre e3)) (editor-post e3)))
; Test character type
(check-expect (handle-character e1 "a")
              (make-editor (string-append (editor-pre e1) "a") (editor-post e1)))
(check-expect (handle-character e1 " ")
              (make-editor (string-append (editor-pre e1) " ") (editor-post e1)))
; Test legal
(check-expect (is-legal-character? "c")
              #true)
(check-expect (is-legal-character? "1")
              #true)
(check-expect (is-legal-character? "\r")
              #false)
(check-expect (is-legal-character? "shift")
              #false)
; Test string-first
(check-expect (string-first "")
              (if (= (string-length "") 0) "" (string-ith "" 0)))
(check-expect (string-first "cats")
              (if (= (string-length "cats") 0) "" (string-ith "cats" 0)))
; Test string-last
(check-expect (string-first "")
              (if (= (string-length "") 0) "" (string-ith "" (- (string-length "") 1))))
(check-expect (string-last "cats")
              (if (= (string-length "cats") 0) "" (string-ith "cats" (- (string-length "cats") 1))))
; Test handle-left
(check-expect (handle-left e1)
              (make-editor (string-remove-last (editor-pre e1))
                           (string-append (string-last (editor-pre e1)) (editor-post e1))))
(check-expect (handle-left e2)
              (make-editor (string-remove-last (editor-pre e2))
                           (string-append (string-last (editor-pre e2)) (editor-post e2))))
(check-expect (handle-left e3)
              (make-editor (string-remove-last (editor-pre e3))
                           (string-append (string-last (editor-pre e3)) (editor-post e3))))
(check-expect (handle-left e4)
              (make-editor (string-remove-last (editor-pre e4))
                           (string-append (string-last (editor-pre e4)) (editor-post e4))))
; Test handle-right
(check-expect (handle-right e1)
              (make-editor (string-append (editor-pre e1) (string-first (editor-post e1)))
                           (string-remove-first (editor-post e1))))
(check-expect (handle-right e2)
              (make-editor (string-append (editor-pre e2) (string-first (editor-post e2)))
                           (string-remove-first (editor-post e2))))
(check-expect (handle-right e3)
              (make-editor (string-append (editor-pre e3) (string-first (editor-post e3)))
                           (string-remove-first (editor-post e3))))
(check-expect (handle-right e4)
              (make-editor (string-append (editor-pre e4) (string-first (editor-post e4)))
                           (string-remove-first (editor-post e4))))
