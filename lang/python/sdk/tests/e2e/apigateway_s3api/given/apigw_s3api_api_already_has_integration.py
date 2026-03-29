"""Given: the "API" already has an S3 integration configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "API" already has an S3 integration configured')
def apigw_s3api_api_already_has_integration():
    pytest.skip("Cannot simulate pre-configured S3 integration conflict in lws")
