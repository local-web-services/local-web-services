"""Given: an "SQS" direct integration has been configured on the "REST" "API" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "SQS" direct integration has been configured on the "REST" "API"')
def apigw_sqs_integration_configured_seq():
    pytest.skip("Cannot configure SQS integration and issue full request for sequence setup in lws")
