"""Given: the prod stage is active"""

from __future__ import annotations

from pytest_bdd import given


@given("the prod stage is active")
def prod_stage_is_active():
    """No-op: stages are active immediately after creation in lws."""
