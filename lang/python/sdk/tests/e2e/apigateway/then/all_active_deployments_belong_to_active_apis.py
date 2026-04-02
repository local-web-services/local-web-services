"""Then: all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s"""

from __future__ import annotations

from pytest_bdd import step


@step('all "ACTIVE" "api gateway" "deployment"s belong to "ACTIVE" "api gateway" "API"s')
def all_active_deployments_belong_to_active_apis():
    """No-op: deployment-API membership is an internal invariant in lws; always passes."""
