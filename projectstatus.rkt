#lang racket/gui

(require "progressbar.rkt")
(require "database.rkt")
(require "gui.rkt")

(define frame
  (new frame%
       [style (list 'metal)]
       [label "Example"]
       [width 800]))

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
;; how is it calling an empty list? 
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

 (define project-status-callback 
  (λ (project-name)
    (λ (create progressbar)
      (send r-msg set-label
            (progressbar-for-status (get-status-for-project project-name))))))
 
;  wrong! 
; (define project-status-callback
;  (λ (project-name status)
;    (λ (create progressbar)
;      (send r-msg set-label
;            (let ((status-from-database (get-status-for-project project-name)))
;              (progressbar-for-status status=from-database))))))  

(define make-project-button%
  (λ (project-name)
    (new button%
         [parent m-panel] 
         [label project-name]
         [callback (project-status-callback project-name)])))

(make-project-button% "kindsource")
(make-project-button% "men-of-revenue-calendar")
(make-project-button% "milk-the-goat")
(make-project-button% "malware for good")

(new message%
         [parent r-panel] 
         [label "progressbar"])
 
(new-project "men-of-revenue-calendar" "7th-floor")
(new-project "kindsource" "sf") 
(new-project "milk-the-goat" "pescadero") 
(new-project "malware for good" "knox's-closet")

(define make-callback
  (λ (status) 
    (λ (button event)
      (send r-msg set-label 
            (progressbar-for-status status)
            ())))

; need a function that makes make-project-button% action speak with set-status-button%. 

(define reset-status
  (λ (project-name status)
    (λ (button event)
      (send r-msg set-label 
          (set-status-for-project project-name status)))))
    
(define set-status-button%
  (λ (status)
    (new button%
         [parent r-panel] 
         [label status] 
         [callback (make-callback status)])))

(define change-project-status 
  (λ (set-status-button% new-status)
    (change-project-status (set-status-for-project new-status))))

(set-status-button% "open")
(set-status-button% "seeking-benevolent-leader")
(set-status-button% "seeking-volunteers")
(set-status-button% "in-progress")
(set-status-button% "shipped")


    
(send frame show #t)