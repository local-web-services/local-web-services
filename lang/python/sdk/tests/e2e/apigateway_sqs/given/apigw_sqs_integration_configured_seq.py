"""Given: a "SQS" direct integration is configured on the "api gateway" "api" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "SQS" direct integration is configured on the "api gateway" "api"')
def apigw_sqs_integration_configured_seq():
    pytest.skip("Cannot configure SQS integration and issue full request for sequence setup in lws")
