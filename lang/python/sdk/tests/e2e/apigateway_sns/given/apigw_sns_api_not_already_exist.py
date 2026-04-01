"""Given: the "sns" "topic" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "API" did not already exist')
def apigw_sns_api_not_already_exist():
    """No-op: fresh state has no REST APIs."""
