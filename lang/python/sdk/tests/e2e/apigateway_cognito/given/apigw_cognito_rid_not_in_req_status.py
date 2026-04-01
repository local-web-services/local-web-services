"""Given: rid not in req_status"""

from __future__ import annotations

from pytest_bdd import given


@given("rid not in req_status")
def apigw_cognito_rid_not_in_req_status():
    """No-op: fresh state has no authorized requests."""
