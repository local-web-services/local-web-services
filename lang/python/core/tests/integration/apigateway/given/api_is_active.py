"""Given: the "API" is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "API" is "ACTIVE"')
def api_is_active():
    """No-op: REST APIs are ACTIVE immediately after creation in lws."""
