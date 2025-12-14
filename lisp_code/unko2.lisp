;;; Common Lisp テストコード
;;; 
;;; VS Code ALIVE で Ctrl+Enter で実行してみてね！

;;; 1. Hello World
(format t "~%=== Hello, Common Lisp! ===~%~%")

;;; 2. 基本的な関数
(defun greet (name)
  "名前でグリーティング"
  (format nil "Hello, ~A!" name))

(print (greet "💩"))

;;; 3. リスト操作
(let* ((numbers '(1 2 3 4 5))
       (doubled (mapcar (lambda (x) (* x 2)) numbers)))
  (format t "~%元のリスト: ~A~%" numbers)
  (format t "2倍にしたリスト: ~A~%~%" doubled))

;;; 4. 簡単なループ
(format t "ループテスト:~%")
(loop for i from 1 to 5
      do (format t "  ~D番目~%" i))

;;; 5. クラス定義（おまけ）
(defclass person ()
  ((name :initarg :name
         :accessor person-name)
   (age :initarg :age
        :accessor person-age)))

(defmethod print-object ((p person) stream)
  (format stream "#<PERSON ~A (~D)>" 
          (person-name p) 
          (person-age p)))

(let ((alice (make-instance 'person :name "Alice" :age 30)))
  (format t "~%オブジェクト: ~A~%~%" alice))

(format t "=== テスト完了！ ===~%")
