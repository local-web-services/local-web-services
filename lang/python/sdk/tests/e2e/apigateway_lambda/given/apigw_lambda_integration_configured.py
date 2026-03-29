"""Given: a Lambda integration has been configured on the REST API"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a Lambda integration has been configured on the REST API")
@given('a Lambda integration has been configured on the "REST" "API"')
def apigw_lambda_integration_configured():
    pytest.skip(
        "Cannot configure Lambda integration and issue full request for sequence setup in lws"
    )
