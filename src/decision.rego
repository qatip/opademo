# Copyright (c) 2026 QA Ltd
# SPDX-License-Identifier: MIT
# OPA Demo - Educational Policy Example
# See LICENSE for licence terms.

package payment.auth

import rego.v1

# ====================
# 1. REQUIRED EVIDENCE
# ====================

# The complete payment decision requires action, role, account status, amount and profile.
# Supporting approval limits and eligible profiles are supplied in DATA.JSON rather than embedded in the policy.

# ====================
# 5. FINAL DECISION
# ====================

# APPROVE represents success. A known violation produces REJECT. REVIEW is used only when required evidence is missing and no known violation already determines the result.

outcome := {
    "decision": "APPROVE",
    "reasons": []
} if {
    allow
}

outcome := {
    "decision": "REJECT",
    "reasons": rejection_reasons
} if {
    count(rejection_reasons) > 0
}

outcome := {
    "decision": "REVIEW",
    "reasons": review_reasons
} if {
    missing_required_evidence
    count(rejection_reasons) == 0
}
