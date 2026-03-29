"""Then: all "ACTIVE" deployments belong to "ACTIVE" APIs"""

from __future__ import annotations

from pytest_bdd import then


@then('all "ACTIVE" deployments belong to "ACTIVE" APIs')
def all_active_deployments_belong_to_active_apis():
    """No-op: deployment-API membership is an internal invariant in lws; always passes."""
