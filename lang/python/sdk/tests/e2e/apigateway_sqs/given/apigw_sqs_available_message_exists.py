"""Given: an "AVAILABLE" message exists in the queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "AVAILABLE" message exists in the queue')
def apigw_sqs_available_message_exists():
    pytest.skip("Cannot pre-seed queue messages for API Gateway integration test in lws")
