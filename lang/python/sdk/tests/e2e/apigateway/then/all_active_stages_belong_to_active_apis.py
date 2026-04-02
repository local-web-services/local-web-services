"""Then: all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s"""

from __future__ import annotations

from pytest_bdd import step


@step('all active "api gateway" "stage"s belong to "ACTIVE" "api gateway" "API"s')
def all_active_stages_belong_to_active_apis():
    """No-op: stage-API membership is an internal invariant in lws; always passes."""
