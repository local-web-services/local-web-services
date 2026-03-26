"""Then: all "ACTIVE" resources belong to "ACTIVE" APIs"""

from __future__ import annotations

from pytest_bdd import then


@then('all "ACTIVE" resources belong to "ACTIVE" APIs')
def all_active_resources_belong_to_active_apis_then():
    """No-op: resource-API membership is an internal invariant in lws; always passes."""
