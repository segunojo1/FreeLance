(define-map tokens
  { user: principal }
  { balance: uint })

(define-public (reward-user (user principal) (amount uint))
  (begin
    (let ((existing (map-get? tokens { user: user })))
      (match existing
        some (map-set tokens { user: user } { balance: (+ (get balance existing) amount) })
        none (map-set tokens { user: user } { balance: amount })))
    (ok "Reward granted!"))
  ))

(define-read-only (get-balance (user principal))
  (map-get? tokens { user: user }))
