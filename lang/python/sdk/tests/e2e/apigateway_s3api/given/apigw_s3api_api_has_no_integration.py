"""Given: the "api gateway" "api" has no S3 integration configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "api" has no S3 integration configured')
def apigw_s3api_api_has_no_integration():
    """No-op: APIs have no S3 integration configured by default."""
