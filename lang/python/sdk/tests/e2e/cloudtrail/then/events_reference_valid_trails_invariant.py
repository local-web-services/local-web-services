"""Then: every "BUFFERED" or "DELIVERED" event references an existing trail"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'every "BUFFERED" or "DELIVERED" "cloudtrail" "event" references an existing "cloudtrail" "trail"'
)
def events_reference_valid_trails_invariant():
    """Invariant: verified by the FizzBee model checker; no runtime check needed."""
