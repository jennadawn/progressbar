#lang scheme

(define makelist
  (lambda (x n)
    (cond 
      ((zero? n) (quote ()))
      (else
        (cons x (makelist x (sub1 n)))))))

(define repeatstring
  (lambda (x n)
    (cond 
      ((zero? n) "")
      (else
        (string-append x (repeatstring x (sub1 n)))))))

(define progressbar
  (lambda (n)
    (string-append (repeatstring "X" n)
                   (repeatstring "-" (- 100 n)))))

;; There are four stages a project can sit at along the road to completion:
;; "open", "seeking-lead", "volunteers", "in-proegress", "shipped"

(define projectstatus
  (lambda (status)
    (cond
      ((eq? status "open") 0)
      ((eq? status "seeking-lead") 25)
      ((eq? status "volunteers") 50) 
      ((eq? status "in-progress") 75)
      ((eq? status "shipped") 100))))

(define progressbar-for-status
  (lambda (status)
    (progressbar (projectstatus status))))

                                                      
