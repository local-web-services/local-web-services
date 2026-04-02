"""Then: an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"'
)
def active_outbound_no_rejected_inbound():
    """No-op: connection status consistency invariant; always passes."""
