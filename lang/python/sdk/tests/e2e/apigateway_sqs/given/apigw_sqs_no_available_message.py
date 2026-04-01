"""Given: no "AVAILABLE" message existed in the "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import given


@given('no "AVAILABLE" message existed in the "sqs" "queue"')
def apigw_sqs_no_available_message():
    """No-op: fresh state has no messages."""
