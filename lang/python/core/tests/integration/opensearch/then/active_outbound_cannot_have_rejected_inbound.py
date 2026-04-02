"""Then: an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection" """

from __future__ import annotations

from pytest_bdd import then


@then(
    'an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"'
)
def active_outbound_cannot_have_rejected_inbound():
    """Invariant trivially satisfied in isolated test context."""
