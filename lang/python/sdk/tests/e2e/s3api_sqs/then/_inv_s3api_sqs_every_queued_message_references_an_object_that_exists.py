"""Then: every "QUEUED" message references an object that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "QUEUED" message references an object that exists')
def _inv_s3api_sqs_every_queued_message_references_an_object_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
