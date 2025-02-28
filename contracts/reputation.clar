(define-map ratings
  { user: principal }
  { total_ratings: uint, rating_sum: uint })

(define-public (rate-user (user principal) (rating uint))
  (begin
    (asserts! (<= rating u5) (err u401))
    (let ((existing (map-get? ratings { user: user })))
      (match existing
        some (map-set ratings { user: user } { total_ratings: (+ (get total_ratings existing) u1), rating_sum: (+ (get rating_sum existing) rating) })
        none (map-set ratings { user: user } { total_ratings: u1, rating_sum: rating })))
    (ok "Rating submitted!")
  ))

(define-read-only (get-user-rating (user principal))
  (let ((data (map-get? ratings { user: user })))
    (match data
      some (ok (/ (get rating_sum data) (get total_ratings data)))
      none (err u402))))
