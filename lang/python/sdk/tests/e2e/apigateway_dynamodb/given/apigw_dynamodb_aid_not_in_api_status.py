"""Given: aid not in api_status"""

from __future__ import annotations

from pytest_bdd import given


@given("aid not in api_status")
def apigw_dynamodb_aid_not_in_api_status():
    """No-op: fresh state has no REST APIs."""
