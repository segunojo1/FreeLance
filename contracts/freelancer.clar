(define-map freelancers
  { id: principal }
  { name: (buff 50), skills: (list 10 (buff 30)), experience: uint, verified: bool })

(define-public (register-freelancer (name (buff 50)) (skills (list 10 (buff 30))) (experience uint))
  (begin
    (asserts! (is-none (map-get? freelancers { id: tx-sender })) (err u101))
    (map-set freelancers { id: tx-sender } { name: name, skills: skills, experience: experience, verified: false })
    (ok "Freelancer registered successfully!")
  ))

(define-read-only (get-freelancer (id principal))
  (map-get? freelancers { id: id }))
