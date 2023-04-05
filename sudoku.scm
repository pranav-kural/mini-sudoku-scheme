;lang scheme

; Author: Pranav K

; Program created in DrRacket IDE

; program parameters
(define DEBUG #f)

; define two sudokus
(define sudoku1 '((2 1 4 3) (4 3 2 1) (1 2 3 4) (3 4 1 2)))
(define sudoku2 '((2 1 4 3) (4 3 2 1) (1 2 3 3) (3 4 1 2)))

; function to print message and then a newline
(define println
  (lambda (x)
    (display x)
    (newline)))

; function to display elements of given list where first element is title and tail contains list to be printed
(define (printlist lst)
  (display (car lst))
  (for-each display (cdr lst))
  (newline))
    
; print when DEBUG is ON
(define (printd x)
  (if (equal? DEBUG #t)
      (println x)
      (display "")))
    

; if debug mode is ON, given list of elements, print each element on a new line
(define (printdl x)
  (if (eqv? DEBUG #t)
      (if (null? (cdr x)) ; if at end of list
          (println (car x)) ; print last element
          (and
           (println (car x))
           (printdl (cdr x)))) ; recursively call for printing next element
       (display "")))
    

(println "-------- Starting program ----------")
(newline)
(printlist (list "debug mode: " (if (eqv? DEBUG #t) "ON" "OFF")))
(newline)
(println "Sudokus being evaluated:")
(printlist (list "Sudoku 1: " sudoku1))
(printlist (list "Sudoku 2: " sudoku2))

; recursive helper function to check if all elements of given list are different
; using HashMap/HashTable for efficiency
(define allDiff?
  (lambda (x y myDict)
    ;(printdl (list x y "-----"))
    
    (if (hash-ref myDict x #f)
        (and (printd "duplicate found") #f)
        (if (null? y) ; if we've reached the end
            (and (printd "reached list end") #t)
            (and
             (hash-set! myDict x #t) ; add current element to dict
             (allDiff? (car y) (cdr y) myDict)) ; recur call allDiff on next element
        ))))

; check if all elements in the list are unqiue. Returns true is all are different
(define different
  (lambda (x)
    ; printing descriptive messages when DEGUB is ON
    (printd (list "Checking for different elements in list " x))
    (define myDict (make-hash))
    (if (allDiff? (car x) (cdr x) myDict)
        #t
        #f)))

; test different function
(printdl (list "Result of different function: " (different (list 2 1 3 4))))

; function to extract 4 columns from given sudoku list
(define extract4Columns
  (lambda (x)
    (if (null? x)
        x
        (extract4Col x))))

; helper function to extact 4 columns of the sudoku
(define extract4Col
  (lambda (x)
    (define row1 (car x))
    (define row2 (cadr x))
    (define row3 (caddr x))
    (define row4 (cadddr x))

     (list
       (list (car row1) (car row2) (car row3) (car row4))
       (list (cadr row1) (cadr row2) (cadr row3) (cadr row4))
       (list (caddr row1) (caddr row2) (caddr row3) (caddr row4))
       (list (cadddr row1) (cadddr row2) (cadddr row3) (cadddr row4)))))

(printd "Testing extract4Columns, result:")
(printd (extract4Columns sudoku1))

; function to extract 4 quadrants of the given sudoku list
(define extract4Quadrants
  (lambda (x)
    (define row1 (car x))
    (define row2 (cadr x))
    (define row3 (caddr x))
    (define row4 (cadddr x))

     (list
       (list (car row1) (cadr row1) (car row2) (cadr row2))
       (list (caddr row1) (cadddr row1) (caddr row2) (cadddr row2))
       (list (car row3) (cadr row3) (car row4) (cadr row4))
       (list (caddr row3) (cadddr row3) (caddr row4) (cadddr row4)))))

(printd "Testing extract4Quadrants, result:")
(printd (extract4Quadrants sudoku1))

; function to merge 3 lists together'
(define merge3
  (lambda (l1 l2 l3)
    (append (append l1 l2) l3)))

(printd "Testing merge3")
(printdl (list "Lists to merge: " '(1 3 6 6 7 8 9) '(5 4) '(1 2 3) "Result: "))
(printd (merge3 '(1 3 6 6 7 8 9) '(5 4) '(1 2 3)))

; helper function to check all elements are true (since andmap and every are not always available)
(define (allTrue? l)
  (cond
    ((null? l) #t) ; if empty, return true
    ((not (car l)) #f) ; if element false, return false
    (else (allTrue? (cdr l))))) ; if not false, check next element

(printdl (list "Testing allTrue on list (#t #t #f), result: " (allTrue? '(#t #t #f))))
(printdl (list "Testing allTrue on list (#t #t #t), result: " (allTrue? '(#t #t #t))))

; function to verify if a given sudoku is valid
(define checkSudoku
  (lambda (x)
    (allTrue? (map different (merge3 x (extract4Columns x) (extract4Quadrants x))))
    ))

; function to run program
; Provide sudoku as first argument, and #t or #f for DEBUG mode
; example: (run '((2 1 4 3) (4 3 2 1) (1 2 3 4) (3 4 1 2)) #f)
(define (run sudoku debugMode)
  (set! DEBUG debugMode)
  (println "-------- Running program ----------")
  (newline)
  (printlist (list "debug mode: " (if (eqv? DEBUG #t) "ON" "OFF")))
  (newline)
  (printlist (list "Sudoku being evaluated: " sudoku))
  (println "Is Sudoku valid? :")
  (println (checkSudoku sudoku)))

(newline)
(println "Is Sudoku1 valid? :")
(println (checkSudoku sudoku1))
(newline)

(println "Is Sudoku2 valid? :")
(println (checkSudoku sudoku2))
(newline)
