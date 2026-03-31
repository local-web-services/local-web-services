"""Given: a backend consumer processes the "sqs" "message" from the "sqs" "queue" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a backend consumer processes the "sqs" "message" from the "sqs" "queue"')
def apigw_sqs_backend_consumer_processed():
    pytest.skip("Cannot represent a completed message consumption as sequence setup in lws")
