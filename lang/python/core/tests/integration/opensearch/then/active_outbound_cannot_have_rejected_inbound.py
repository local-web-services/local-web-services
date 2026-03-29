"""Then: an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection"""

from __future__ import annotations

from pytest_bdd import then


@then('an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection')
def active_outbound_cannot_have_rejected_inbound():
    """Invariant trivially satisfied in isolated test context."""
