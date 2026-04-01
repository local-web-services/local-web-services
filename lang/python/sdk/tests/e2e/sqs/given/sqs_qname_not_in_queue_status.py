"""Given: qname not in queue_status"""

from __future__ import annotations

from pytest_bdd import given


@given("qname not in queue_status")
def sqs_qname_not_in_queue_status():
    """No-op: fresh state has no queues."""
