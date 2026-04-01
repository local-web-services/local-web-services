"""Given: an "AVAILABLE" message existed in the "sqs" "queue" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "AVAILABLE" message existed in the "sqs" "queue"')
def apigw_sqs_available_message_exists():
    pytest.skip("Cannot pre-seed queue messages for API Gateway integration test in lws")
