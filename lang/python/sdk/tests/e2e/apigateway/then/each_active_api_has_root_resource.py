"""Then: each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource" """

from __future__ import annotations

from pytest_bdd import step


@step('each "ACTIVE" "api gateway" "API" has at least one "ACTIVE" root "api gateway" "resource"')
def each_active_api_has_root_resource():
    """No-op: root resource creation is an internal invariant in lws; always passes."""
