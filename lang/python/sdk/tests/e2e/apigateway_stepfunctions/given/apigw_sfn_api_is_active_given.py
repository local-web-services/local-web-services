"""Given: the "API" is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "API" is "ACTIVE"')
def apigw_sfn_api_is_active_given():
    """No-op: REST APIs are ACTIVE immediately after creation."""
