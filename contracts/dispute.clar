(define-map disputes
  { job_id: uint }
  { client: principal, freelancer: principal, reason: (buff 200), resolved: bool })

(define-public (raise-dispute (job_id uint) (reason (buff 200)))
  (begin
    (asserts! (is-none (map-get? disputes { job_id: job_id })) (err u601))
    (map-set disputes { job_id: job_id } { client: tx-sender, freelancer: (get freelancer (unwrap! (map-get? jobs { job_id: job_id }) u0)), reason: reason, resolved: false })
    (ok "Dispute raised!"))
  ))

(define-public (resolve-dispute (job_id uint))
  (begin
    (asserts! (is-some (map-get? disputes { job_id: job_id })) (err u602))
    (map-set disputes { job_id: job_id } { client: (get client (unwrap! (map-get? disputes { job_id: job_id }) u0)), freelancer: (get freelancer (unwrap! (map-get? disputes { job_id: job_id }) u0)), reason: (get reason (unwrap! (map-get? disputes { job_id: job_id }) u0)), resolved: true })
    (ok "Dispute resolved!"))
  ))
