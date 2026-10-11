# Copyright (c) 2026 QA Ltd
# SPDX-License-Identifier: MIT
# OPA Demo - Educational Policy Example
# See LICENSE for licence terms.

package payment.auth

import rego.v1

# ====================
# 3. POLICY CHECKS
# ====================

# The normal allow rule checks the complete request against the policy and supporting DATA.JSON.

default allow := false

# Named checks make the business conditions independently readable.
# These helper rules intentionally preserve the checks from Example 8.

permitted_action if {
    input.action == "initiate_payment"
}

permitted_role if {
    input.role == "payment_initiator"
}

active_account if {
    input.account.status == "active"
}

within_role_limit if {
    input.amount <= data.approval_limits[input.role]
}

eligible_profile if {
    input.profile in data.eligible_profiles
}

allow if {
    permitted_action
    permitted_role
    active_account
    within_role_limit
    eligible_profile
}

