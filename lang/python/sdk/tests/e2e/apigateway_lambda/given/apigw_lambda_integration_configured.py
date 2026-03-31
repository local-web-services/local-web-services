"""Given: a Lambda integration is configured on the "api gateway" "api" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a Lambda integration is configured on the "api gateway" "api"')
@given('a Lambda integration is configured on the "api gateway" "api"')
def apigw_lambda_integration_configured():
    pytest.skip(
        "Cannot configure Lambda integration and issue full request for sequence setup in lws"
    )
