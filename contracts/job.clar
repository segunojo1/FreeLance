(define-map jobs
  { job_id: uint }
  { client: principal, title: (buff 70), description: (buff 200), budget: uint, status: (buff 20) })

(define-map bids
  { job_id: uint, freelancer: principal }
  { bid_amount: uint, proposal: (buff 150) })

(define-public (post-job (job_id uint) (title (buff 70)) (description (buff 200)) (budget uint))
  (begin
    (asserts! (is-none (map-get? jobs { job_id: job_id })) (err u201))
    (map-set jobs { job_id: job_id } { client: tx-sender, title: title, description: description, budget: budget, status: "open" })
    (ok "Job posted successfully!")
  ))

(define-public (place-bid (job_id uint) (bid_amount uint) (proposal (buff 150)))
  (begin
    (asserts! (is-some (map-get? jobs { job_id: job_id })) (err u202))
    (map-set bids { job_id: job_id, freelancer: tx-sender } { bid_amount: bid_amount, proposal: proposal })
    (ok "Bid placed successfully!")
  ))
