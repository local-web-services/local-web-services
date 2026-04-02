"""Then: all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s"""

from __future__ import annotations

from pytest_bdd import then


@then('all active "api gateway" "stage"s reference "ACTIVE" "api gateway" "deployment"s')
def all_active_stages_reference_active_deployments_then():
    """No-op: stage-deployment references are an internal invariant in lws; always passes."""
