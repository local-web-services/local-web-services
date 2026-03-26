"""Given: the queue does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the queue does not exist")
def apigw_sqs_queue_does_not_exist():
    """No-op: fresh state has no queues."""
