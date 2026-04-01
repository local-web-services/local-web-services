"""Given: the "api gateway" "API" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "API" was "ACTIVE"')
def api_is_active_given(lws_session):
    """No-op: in lws, REST APIs are ACTIVE immediately after creation."""
