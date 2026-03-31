"""Given: a direct S3 integration is configured on the "api gateway" "API" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a direct S3 integration is configured on the "api gateway" "API"')
def apigw_s3api_s3_integration_configured():
    pytest.skip("Cannot configure S3 integration and issue full request for sequence setup in lws")
