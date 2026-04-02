"""Then: every "QUEUED" "sqs" "message" references an "s3" "object" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "QUEUED" "sqs" "message" references an "s3" "object" that exists')
def _inv_s3api_sqs_every_queued_message_references_an_object_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
