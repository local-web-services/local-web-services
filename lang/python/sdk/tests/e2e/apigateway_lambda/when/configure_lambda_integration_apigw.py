"""When: a Lambda integration is configured on the "REST" "API" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a Lambda integration is configured on the "REST" "API"')
def configure_lambda_integration_apigw(world):
    pytest.skip("Cannot configure Lambda integration on REST API in lws")
