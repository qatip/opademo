# Copyright (c) 2026 QA Ltd
# SPDX-License-Identifier: MIT
# OPA Demo - Educational Policy Example
# See LICENSE for licence terms.

package payment.auth

import rego.v1

# ====================
# 2. MISSING EVIDENCE
# ====================

# Each missing required fact produces a specific review reason. Missing evidence is not treated as a known policy violation.

review_reasons contains "Action is required" if {
    object.get(input, "action", null) == null
}

review_reasons contains "Role is required" if {
    object.get(input, "role", null) == null
}

review_reasons contains "Account status is required" if {
    account := object.get(input, "account", {})
    object.get(account, "status", null) == null
}

review_reasons contains "Payment amount is required" if {
    object.get(input, "amount", null) == null
}

review_reasons contains "Profile is required" if {
    object.get(input, "profile", null) == null
}

missing_required_evidence if {
    count(review_reasons) > 0
}

