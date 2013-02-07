#lang racket/gui

(require "progressbar.rkt")
(require "database.rkt")

;;(provide make-callback)
;;(provide make-button%) 

; Make a frame by instantiating the frame% class
;; For Jenna -- right-click on the frame% (or anything with % at the end) and hit "View Documentation" to see other
;; options that you can pass in after the name.

(define frame
  (new frame%
       [style (list 'metal)]
       [label "Example"]
       [width 500]))

 
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

; Make a static text message in the frame


(send frame show #f)