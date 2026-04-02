"""Given: the target "sqs" "queue" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sqs" "queue" was "ACTIVE"')
def apigw_sqs_queue_is_active_given():
    """No-op: SQS queues are ACTIVE immediately after creation."""
