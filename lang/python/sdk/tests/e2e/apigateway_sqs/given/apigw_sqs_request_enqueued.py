"""Given: the "api gateway" "API" receives a request and enqueues it as a "SQS" message"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "API" receives a request and enqueues it as a "SQS" message')
def apigw_sqs_request_enqueued():
    pytest.skip("Cannot represent a completed API-to-SQS enqueue as sequence setup in lws")
