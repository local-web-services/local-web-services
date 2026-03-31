"""Given: a direct "SNS" integration is configured on the "api gateway" "API" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a direct "SNS" integration is configured on the "api gateway" "API"')
def apigw_sns_integration_configured_seq():
    pytest.skip("Cannot configure SNS integration and issue full request for sequence setup in lws")
