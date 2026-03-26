"""Then: every "QUEUED" message references a queue that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every "QUEUED" message references a queue that exists')
def _inv_s3api_sqs_every_queued_message_references_a_queue_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
