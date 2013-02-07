#lang racket

(provide new-project
         set-status-for-project
         get-status-for-project
         main-database)



;; Keys are project names, values are another database.
(define main-database (make-hash))

;; Make hash can take a list of "pairs" -- you make a pair
;; by "cons"ing two things together.
(define create-project-deets 
  (lambda (location)
    (make-hash
     (list
      (cons "status" "open")
      (cons "location" location)))))

(define new-project
  (lambda (project-name location)
    (hash-set! main-database project-name (create-project-deets location))))


;; Use to put key-value pairs into the database:
(define set-status-for-project
  (lambda (project-name status)
     (let ((project-database (hash-ref main-database project-name)))
       (hash-set! project-database "status" status))))


;; Use this to get a value out of the database for a specific key:
(define get-status-for-project 
  (lambda (project-name)
    (let ((project-database (hash-ref main-database project-name)))
      (hash-ref project-database "status")))) 
         
;; SAVE THIS FOR LATER.
;; Now, we get to make a database. A database is a (drumroll) KEY VALUE STORE!!

;; NOTES FOR JENNA
;;
;; (make-hash) returns a new database. It's in the list by itself since it's a function
;; with NO arguments.
;;
;; (hash-set! <database> <key> <value>) sets a key-value pair within a database (I call
;; it a hashtable)
;;
;; (hash-ref <database> <key>) goes into a database and gets out the value for a key.
;;
;; Let (name (thing you want to name)  - creates a temporary name for something 


;; ASSIGNMENT -- create a "set-status-for-project" function that takes two arguments: project-name and status.
;; Then create a "get-status-for-project" function that takes one argument: project-name.
;;
;; the main database should have keys that are "project name" and values that are their own little databases (create with (make-hash)).
