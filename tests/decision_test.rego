# Copyright (c) 2026 QA Ltd
# SPDX-License-Identifier: MIT
# OPA Demo - Educational Policy Example
# See LICENSE for licence terms.

package payment.auth_test

import rego.v1
import data.payment.auth

test_approve if {
    auth.outcome.decision == "APPROVE" with input as {"profile": "BUSINESS-001", "role": "payment_initiator", "action": "initiate_payment", "account": {"id": "BUS-12345", "status": "active"}, "amount": 12500}
}

test_reject_inactive_account if {
    result := auth.outcome with input as {"profile": "BUSINESS-001", "role": "payment_initiator", "action": "initiate_payment", "account": {"id": "BUS-12345", "status": "inactive"}, "amount": 12500}
    result.decision == "REJECT"
    "Account is not active" in result.reasons
}

test_review_missing_profile if {
    result := auth.outcome with input as {"role": "payment_initiator", "action": "initiate_payment", "account": {"id": "BUS-12345", "status": "active"}, "amount": 12500}
    result.decision == "REVIEW"
    "Profile is required" in result.reasons
}

test_known_rejection_takes_precedence_over_review if {
    result := auth.outcome with input as {"role": "payment_initiator", "action": "initiate_payment", "account": {"id": "BUS-12345", "status": "inactive"}, "amount": 12500}
    result.decision == "REJECT"
}
