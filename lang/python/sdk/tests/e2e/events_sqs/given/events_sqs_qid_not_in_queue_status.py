"""Given: qid not in queue_status"""

from __future__ import annotations

from pytest_bdd import given


@given("qid not in queue_status")
def events_sqs_qid_not_in_queue_status():
    """No-op: fresh state has no queues."""
