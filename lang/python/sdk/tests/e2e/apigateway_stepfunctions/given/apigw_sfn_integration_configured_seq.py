"""Given: a Step Functions direct integration is configured on the "api gateway" "api" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a Step Functions direct integration is configured on the "api gateway" "api"')
def apigw_sfn_integration_configured_seq():
    pytest.skip(
        "Cannot configure StepFunctions integration and issue full request for sequence setup in lws"  # noqa: E501
    )
