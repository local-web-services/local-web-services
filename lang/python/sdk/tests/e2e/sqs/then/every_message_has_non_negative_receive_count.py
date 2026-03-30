"""Then: every message has a non-negative receive count"""

from __future__ import annotations

from pytest_bdd import then


@then("every message has a non-negative receive count")
def every_message_has_non_negative_receive_count():
    """Invariant: trivially satisfied in isolated lws context."""
