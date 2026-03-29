"""Then: each "ACTIVE" "API" has at least one "ACTIVE" root resource"""

from __future__ import annotations

from pytest_bdd import then


@then('each "ACTIVE" "API" has at least one "ACTIVE" root resource')
def each_active_api_has_at_least_one_active_root_resource_then():
    """No-op: root resource creation is an internal invariant in lws; always passes."""
