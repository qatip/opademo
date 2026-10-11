# Copyright (c) 2026 QA Ltd
# SPDX-License-Identifier: MIT
# OPA Demo - Educational Policy Example
# See LICENSE for licence terms.

package payment.auth

import rego.v1

# ====================
# 4. VIOLATIONS
# ====================

# Values that are present but violate policy are collected as rejection reasons.

rejection_reasons contains "Action is not permitted" if {
    object.get(input, "action", null) != null
    input.action != "initiate_payment"
}

rejection_reasons contains "Role is not permitted to initiate payments" if {
    object.get(input, "role", null) != null
    input.role != "payment_initiator"
}

rejection_reasons contains "Account is not active" if {
    account := object.get(input, "account", {})
    object.get(account, "status", null) != null
    account.status != "active"
}

rejection_reasons contains "Payment exceeds the role limit" if {
    object.get(input, "amount", null) != null
    object.get(input, "role", null) != null
    limit := object.get(data.approval_limits, input.role, null)
    limit != null
    input.amount > limit
}

rejection_reasons contains "Profile is not eligible" if {
    object.get(input, "profile", null) != null
    not input.profile in data.eligible_profiles
}

