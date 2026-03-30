"""Given: the "API" is not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "API" is not "CREATING"')
def api_is_not_creating_given():
    """No-op: in lws, created APIs are ACTIVE (never CREATING) by default."""
