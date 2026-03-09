(= (_clamp01 $x)
  (if (and (< $x 1) (> $x 0))
     $x
     (if (> $x 1)
      1
      0
      )
   )
)


(= (replaceByIndex $expr $index $new)
    (if (== $expr ())
        $expr
        (let*
            (
                ($first (car-atom $expr))
                ($tail (cdr-atom $expr))
            )
            (if (== $index 0)
                (if (== $tail ())
                    ($new)
                    (cons-atom $new $tail)
                )
                (let $c (replaceByIndex $tail (- $index 1) $new)
                    (cons-atom $first $c)
                )))))


;  novelty_signal = _clamp01(
;         0.35 * cx
;         + 0.35 * (1.0 - familiarity_signal)
;         + 0.20 * reflective_intent
;         + 0.10 * ambiguity
;     )
;     arousal_target = _clamp01(
;         0.25 + 0.40 * target_u + 0.35 * novelty_signal + 0.20 * cx
;     )

;  # 10. RISK AVERSION (m_risk_aversion)
;     risk_aversion_target = _clamp01(
;         0.40 * threshold_signal +                  # High threshold = risk averse
;         0.30 * failure_signal +                    # Recent failures = risk averse
;         0.20 * ambiguity +                          # Ambiguity = risk averse
;         0.10 * (1.0 if urgent_flag else 0.0)        # Urgency slightly reduces risk aversion? (wait, this adds)
;     )
;     mods["risk_aversion"] = _clamp01(
;         (1.0 - params["risk_aversion_alpha"]) * float(mods.get("risk_aversion", 0.4))
;         + params["risk_aversion_alpha"] * risk_aversion_target
;     )
    
;     # 11. ERROR TOLERANCE (m_error_tolerance)
;     error_tolerance_target = _clamp01(
;         0.45 +                                     # Base tolerance
;         0.25 * (1.0 - threshold_signal) +          # Low threshold = more tolerant
;         0.20 * familiarity_signal +                 # Familiar topics = more tolerant
;         0.15 * (1.0 - failure_signal) -            # No failures = more tolerant
;         0.20 * ambiguity -                          # Ambiguity = less tolerant
;         0.10 * (1.0 if urgent_flag else 0.0)        # Urgency = less tolerant
;     )
;     mods["error_tolerance"] = _clamp01(
;         (1.0 - params["error_tolerance_alpha"]) * float(mods.get("error_tolerance", 0.45))
;         + params["error_tolerance_alpha"] * error_tolerance_target
;     )
;  (+ 0.45 (+ (* 0.25 (- 1 (getContext threshold))) (+ (* 0.2 (getContext familiarity_signal)) (- (* 0.15 (- 1  (getContext failure_signal))) (- (* 0.2 getContext ambiguity) (* 0.1 (if (== (getContext urgent) 1) 1 0)))))))
;     # 12. CREATIVITY (m_creativity)
;     creativity_target = _clamp01(
;         0.30 +                                      # Base creativity
;         0.30 * (1.0 - familiarity_signal) +         # Unfamiliar = more creative
;         0.20 * cx +                                  # Complex = more creative
;         0.15 * (1.0 - threshold_signal) +            # Low threshold = more creative
;         0.20 * reflective_intent -                   # Reflective = more creative
;         0.10 * failure_signal                         # Failures reduce creativity
;     )
;     mods["creativity"] = _clamp01(
;         (1.0 - params["creativity_alpha"]) * float(mods.get("creativity", 0.45))
;         + params["creativity_alpha"] * creativity_target
;     )
    
;     # 13. VALENCE (m_valence) - overall positive/negative feeling
;     valence_target = _clamp11(
;         valence_signal -                             # Direct from context
;         0.10 * failure_signal                         # Failures reduce valence
;     )
;     mods["valence"] = _clamp11(
;         (1.0 - params["valence_alpha"]) * float(mods.get("valence", 0.0))
;         + params["valence_alpha"] * valence_target
;     )





; a function to add the list of alpha(a hyperparameter)  in to atomespace for modulator-updator (increamental blending)
; (= (add-alpha $space $list)
 
;  (if (== $list ())
;     ()
;  (let* (
;     ($head (car-atom $list))
;     ($tail (cdr-atom $list))
;     ($_ (add-atom $space $head))
;     )
;     (add-alpha $space $tail)
;  )
;  ))

; get a single hyper-parameter from space to calculate its respective modulator
; (= (get-alpha $name)
;       (match &space ($name $y) $y)
; )

; a function to add llm extracted context(perception) into atomspace 
; (= (add-context $space) 
;   (let* (
;     ($context-value (py-call (context.check)))
;     ($_ (add-atom $space $context-value)))
;     $context-value 
;     )
; )



(= (_clamp11 $x)
  (if (and (< $x 1) (> $x -1))
     $x
     (if (> $x 1)
      1
      -1
      )
   )
)