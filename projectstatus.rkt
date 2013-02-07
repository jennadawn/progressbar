#lang racket/gui

(require "progressbar.rkt")
(require "database.rkt")
(require "gui.rkt")


(define frame
  (new frame%
       [style (list 'metal)] 
       [label "Project Page"]
       [width 700]))

(define panel
  (new horizontal-panel%
       [parent frame]))

(define l-panel
  (new vertical-panel%
       [parent panel]))

(define m-panel
  (new vertical-panel%
       [parent panel]))

(define r-panel
  (new vertical-panel%
       [parent panel]))

(define l-msg
  (new message%
       [parent l-panel]
       [horiz-margin 30]
       [label "lefty!"]
       [min-width 300]))

(define m-msg
  (new message%
       [parent m-panel]
       [horiz-margin 30]
       [label "project-list"]
       [min-width 300]))

(define r-msg
  (new message%
       [parent r-panel]
       [horiz-margin 10]
       [label "righty!"]
       [min-width 600]))

(define project-name-text 
  (new text-field%
     [label "Project Name"]
     [parent l-panel]))

(define location-text
  (new text-field%
     [label "Project Location"]
     [parent l-panel]))

(define add-project-to-database
  (λ ()
   (let ((project-name (send project-name-text get-value)) 
         (location (send location-text get-value))) 
     (new-project project-name location)
     (make-project-button% project-name))))
             
(new button%
  [parent l-panel] 
  [label "create project"]
  [callback (λ (add project)
            (add-project-to-database))])
  
;; how do I create one callback for two text-fields? 
 
; set current project is a function that takes a project name and holds it until another project button is clicked on. 
   ; create a new database for this temp project name?

(define current-project-database (make-hash))
 
(define current-project-deets
  (λ (project-name)
    (make-hash 
     (list
      (cons "current-project" project-name)))))

(define set-current-project 
  (λ (project-name)
   (hash-set! current-project-database "current-project" project-name)))
   
(define make-project-callback 
  (λ (project-name)
    (λ (button event)
      (set-current-project project-name)
      (send r-msg set-label (progressbar-for-status (get-status-for-project project-name))))))

(define make-project-button%
  (λ (project-name)
    (new button%
         [parent m-panel] 
         [label project-name]
         [callback (make-project-callback project-name)])))

(make-project-button% "kindsource")
(make-project-button% "men of revenue calendar")
(make-project-button% "milk-the-goat")
(make-project-button% "malware for good")


; get current project takes the project name from the set current project function and finds it's status in the project-database 

                   
(new message%
         [parent r-panel] 
         [label "progressbar"])
 
(new-project "men of revenue calendar" "7th-floor")
(new-project "kindsource" "sf") 
(new-project "milk-the-goat" "pescadero") 
(new-project "malware for good" "knox's closet")

(define get-current-project 
  (λ ()
   (hash-ref current-project-database "current-project")))
 
(define make-status-callback
  (λ (status)
    (λ (button event) 
       (set-status-for-project (get-current-project) status)
       (send r-msg set-label (progressbar-for-status status)))))

(define set-status-button%
  (λ (status)
    (new button%
         [parent r-panel] 
         [label status]
         [callback (make-status-callback status)])))
 
(set-status-button% "open")
(set-status-button% "seeking-benevolent-leader")
(set-status-button% "seeking-volunteers")
(set-status-button% "in-progress")
(set-status-button% "shipped")

    
(send frame show #t)