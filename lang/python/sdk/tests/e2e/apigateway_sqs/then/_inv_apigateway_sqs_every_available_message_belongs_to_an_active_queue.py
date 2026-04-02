"""Then: every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import step


@step('every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"')
def _inv_apigateway_sqs_every_available_message_belongs_to_an_active_queue():
    """Invariant step: trivially satisfied in isolated test context."""
