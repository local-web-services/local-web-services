"""Given: the queue does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the queue does not already exist")
def apigw_sqs_queue_not_already_exist():
    """No-op: fresh state has no queues."""
