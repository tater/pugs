(in-package #:kp6-cl)

(kp6-create-package "GLOBAL")

;;; Defines a new
(defmacro define-kp6-function (name-and-options params &body body)
  "Define a new function in Perl 6 land, within the given package.
RETURNS may be specified to unconditionally return a value \(it will
be passed through CL->PERL first; for example, :RETURNS 'TRUE will
result in \(MAKE-INSTANCE 'KP6-BIT :VALUE 1\)\)."
  (destructuring-bind (name &key (package "GLOBAL") returns) (if (listp name-and-options) name-and-options (list name-and-options))
    `(progn
      (when (null (kp6-find-package ,package))
	(kp6-create-package ,package))
      (kp6-store (kp6-find-package ,package)
       ',(kp6-normalize-function-name name)
       (make-instance 'kp6-Code
	:value #'(lambda ,params
		   ,@body
		   ,@(when (not (null returns))
			   (list `(cl->perl ,returns)))))))))

(flet ((call-kp6-function (name args)
	 (kp6-apply-function (kp6-normalize-function-name name) args)))
  (define-kp6-function "elems" (array)
    (assert (typep array 'kp6-Array) (array))
    (length (kp6-value array)))

  ;;; TODO: All these functions need to _num or _str their arguments,
  ;;; the string functions currently die on numeric arguments and vice
  ;;; versa for the numeric functions

  (define-kp6-function "infix:<eq>" (first second)
    (cl->perl (if (string= (perl->cl (kp6-str first)) (perl->cl (kp6-str second)))
		  'true
		  'false)))

  (define-kp6-function "infix:<ne>" (first second)
    (cl->perl (if (string= (perl->cl (kp6-str first)) (perl->cl (kp6-str second)))
		  'false
		  'true)))

  (define-kp6-function "infix:<==>" (first second)
    (cl->perl (if (equal (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))
		  'true
		  'false)))

  (define-kp6-function "infix:<!=>" (first second)
    (cl->perl (if (equal (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))
		  'false
		  'true)))

  (define-kp6-function "infix:<<>" (first second)
    (cl->perl (< (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))))

  (define-kp6-function "infix:<>>" (first second)
    (cl->perl (> (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))))


  (define-kp6-function "infix:<<=>" (first second)
    (cl->perl (<= (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))))

  (define-kp6-function "infix:<>=>" (first second)
    (cl->perl (>= (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))))

  (define-kp6-function "infix:<<=>>" (first second)
    ; (defun <=> (a b) (signum (- a b)))
    (cl->perl (signum (- (perl->cl (kp6-num first)) (perl->cl (kp6-num second))))))

  (define-kp6-function "infix:<+>" (first second)
    (cl->perl (+ (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))))

  (define-kp6-function "infix:<->" (first second)
    (cl->perl (- (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))))

  (define-kp6-function "infix:<*>" (first second)
    (cl->perl (* (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))))

  (define-kp6-function "infix:</>" (first second)
    (cl->perl (/ (perl->cl (kp6-num first)) (perl->cl (kp6-num second)))))

  (define-kp6-function "infix:<~>" (&rest strs)
    (cl->perl (format nil "~{~A~}" (mapcar #'perl->display strs))))

  (define-kp6-function "length" (&rest strs)
    (cl->perl (length (perl->cl (kp6-str (first strs))))))

  (define-kp6-function "infix:<&&>" (&rest operands)
    (if (null operands)
        (cl->perl 'true)
        (if (kp6-bit (first operands))
            (call-kp6-function "infix:<&&>" (cdr operands))
            (cl->perl 'false))))

  (define-kp6-function "infix:<||>" (&rest operands)
    (if (null operands)
        (cl->perl 'false)
        (let ((operand (first operands)))
          (if (kp6-bit operand)
              operand
              (call-kp6-function "infix:<||>" (cdr operands))))))

  (define-kp6-function ("print" :returns 'true) (&rest strs)
    (format t "~{~A~}" (mapcar #'perl->display strs)))

  (define-kp6-function ("say" :returns 'true) (&rest strs)
    (call-kp6-function "print" strs)
    (terpri))

  (define-kp6-function ("warn" :returns 'true) (&rest strs)
    (warn "~A" (call-kp6-function "infix:<~>" strs)))

  (define-kp6-function "defined" (object)
    (not (null (kp6-value object))))

  (define-kp6-function "substr" (string offset &optional length)
    (assert (typep string 'kp6-Str))
    (assert (typep offset 'kp6-Int))
    (let* ((string (kp6-value string))
	   (offset (kp6-value offset))
	   (actual-length (length string))
	   (end (cond
		  (length
		   (assert (typep length 'kp6-Int))
		   (+ offset (kp6-value length)))
		  (t actual-length))))
      (assert (>= actual-length offset))
      (assert (>= actual-length end))
      (subseq string offset end))))