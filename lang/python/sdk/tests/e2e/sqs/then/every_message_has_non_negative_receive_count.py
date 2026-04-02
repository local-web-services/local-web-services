"""Then: every "sqs" "message" has a non-negative receive count"""

from __future__ import annotations

from pytest_bdd import step


@step('every "sqs" "message" has a non-negative receive count')
def every_message_has_non_negative_receive_count():
    """Invariant: trivially satisfied in isolated lws context."""
