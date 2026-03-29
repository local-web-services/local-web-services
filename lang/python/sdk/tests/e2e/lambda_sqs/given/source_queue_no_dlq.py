"""Given: the source queue has no dead-letter queue configured"""

from __future__ import annotations

from pytest_bdd import given


@given("the source queue has no dead-letter queue configured")
def source_queue_no_dlq():
    """No-op: queue created without a DLQ."""
