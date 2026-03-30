"""Given: the "API" has received a request and enqueued it as an "SQS" message"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "API" has received a request and enqueued it as an "SQS" message')
def apigw_sqs_request_enqueued():
    pytest.skip("Cannot represent a completed API-to-SQS enqueue as sequence setup in lws")
