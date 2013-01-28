#lang racket/gui

(require "progressbar.rkt")

; Make a frame by instantiating the frame% class
;; For Jenna -- right-click on the frame% (or anything with % at the end) and hit "View Documentation" to see other
;; options that you can pass in after the name.
(define frame
  (new frame%
       [style (list 'metal)]
       [label "Example"]
       [width 300]))
 
; Make a static text message in the frame
(define msg
  (new message%
       [parent frame]
       [horiz-margin 10]
       [label "This is my starting label!"]
       [min-width 800]))
 
;; a panel is a way to group up a bunch of stuff so that you don't have
;; to deal with each item individually. This panel will be grouping
;; a bunch of buttons.
(define panel
  (new vertical-panel%
       ;; This panel's parent is the "frame" object we defined above!
       [parent frame]))


;; This creates a new button with some options.
;; I named this button "open-button" with define. Notice that the other buttons
;; below don't have this -- that's because we don't need to refer to the buttons
;; by name (at this point!) If we wanted to later, we'd have to name them all like this one.
(define open-button
  (new button%
       ;; This button's parent is the "panel" we just defined :)
       [parent panel]
       [label "Open"]
       [callback
        ;; This is a function that the system will call when someone pushes
        ;; the button. Totally cool to not use the arguments, or name
        ;; them something else! The only requirement is that you
        ;; pass in a lambda with two arguments.
        (lambda (button event)
          (send msg set-label (progressbar-for-status "open")))]))

(new button%
     [parent panel]
     [label "Seeking Lead"]
     [callback 
      (lambda (button event)
        (send msg set-label (progressbar-for-status "seeking-lead")))])

;; Task 1: Look at the code above and with some strategic copy-paste, create the rest of the buttons.

;; Task 2: Create a FUNCTION that can accept a status and RETURN a button that prints out the progressbar for that status.

; Show the frame by calling its show method
(send frame show #f)