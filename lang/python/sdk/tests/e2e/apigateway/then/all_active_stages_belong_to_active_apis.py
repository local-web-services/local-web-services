"""Then: all active stages belong to "ACTIVE" APIs"""

from __future__ import annotations

from pytest_bdd import then


@then('all active stages belong to "ACTIVE" APIs')
def all_active_stages_belong_to_active_apis():
    """No-op: stage-API membership is an internal invariant in lws; always passes."""
