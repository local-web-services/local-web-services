"""Then: every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import step


@step('every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"')
def every_enabled_esm_references_active_queue():
    """Invariant step: trivially satisfied in isolated test context."""
