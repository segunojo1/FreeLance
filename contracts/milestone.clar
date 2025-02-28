(define-map milestones
  { job_id: uint, milestone_id: uint }
  { description: (buff 100), amount: uint, completed: bool })

(define-public (add-milestone (job_id uint) (milestone_id uint) (description (buff 100)) (amount uint))
  (begin
    (asserts! (is-some (map-get? jobs { job_id: job_id })) (err u501))
    (map-set milestones { job_id: job_id, milestone_id: milestone_id } { description: description, amount: amount, completed: false })
    (ok "Milestone added!")
  ))

(define-public (complete-milestone (job_id uint) (milestone_id uint))
  (begin
    (asserts! (is-some (map-get? milestones { job_id: job_id, milestone_id: milestone_id })) (err u502))
    (map-set milestones { job_id: job_id, milestone_id: milestone_id } { description: (get description (unwrap! (map-get? milestones { job_id: job_id, milestone_id: milestone_id }) u0)), amount: (get amount (unwrap! (map-get? milestones { job_id: job_id, milestone_id: milestone_id }) u0)), completed: true })
    (ok "Milestone completed!"))
  ))
