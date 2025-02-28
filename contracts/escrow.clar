(define-map escrow
  { job_id: uint }
  { client: principal, freelancer: principal, amount: uint, released: bool })

(define-public (deposit-payment (job_id uint) (freelancer principal) (amount uint))
  (begin
    (asserts! (is-some (map-get? jobs { job_id: job_id })) (err u301))
    (asserts! (is-none (map-get? escrow { job_id: job_id })) (err u302))
    (map-set escrow { job_id: job_id } { client: tx-sender, freelancer: freelancer, amount: amount, released: false })
    (ok "Payment deposited in escrow!")
  ))

(define-public (release-payment (job_id uint))
  (begin
    (let ((escrow-data (map-get? escrow { job_id: job_id })))
      (match escrow-data
        some (if (is-eq (get client escrow-data) tx-sender)
                 (begin
                   (map-set escrow { job_id: job_id } (merge escrow-data { released: true }))
                   (ok "Payment released!"))
                 (err u303))
        none (err u304))))
