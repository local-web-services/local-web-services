"""Given: the "sns" "topic" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "api" was "ACTIVE"')
def apigw_sns_api_is_active_given():
    """No-op: REST APIs are ACTIVE immediately after creation."""
