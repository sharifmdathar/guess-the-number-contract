;; ---------------------------------------------------------
;; Guess the Number - Clarity Contract
;; ---------------------------------------------------------

(define-data-var secret-number uint u0)
(define-data-var game-active bool false)

(define-constant contract-owner tx-sender)

;; -------------------------
;; Start a new game
;; -------------------------
(define-public (start-game (number uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner)
      (err "Only owner can start a game")
    )
    (asserts! (and (>= number u1) (<= number u100))
      (err "Number must be between 1 and 100")
    )
    (var-set secret-number number)
    (var-set game-active true)
    (ok "Game started! Guess the number")
  )
)

;; -------------------------
;; Make a guess
;; -------------------------
(define-public (make-guess (guess uint))
  (begin
    (asserts! (var-get game-active) (err "No active game"))
    (let ((secret (var-get secret-number)))
      (if (is-eq guess secret)
        (begin
          (var-set game-active false)
          (ok "Correct! You win the game")
        )
        (if (< guess secret)
          (err "Your guess is too low, try a higher number")
          (err "Your guess is too high, try a lower number")
        )
      )
    )
  )
)
