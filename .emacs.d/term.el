(use-package term
  :config
  (progn
    (defun my/term-exec-hook ()
      (let* ((buff (current-buffer))
             (proc (get-buffer-process buff)))
        (set-process-sentinel
         proc
         `(lambda (process event)
            (if (string= event "finished\n")
                (kill-buffer buff))))))

    (add-hook 'term-exec-hook 'my/term-exec-hook)))
