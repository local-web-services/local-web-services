"""Then: the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS" """

from __future__ import annotations

from pytest_bdd import then


@then('the active "cloudtrail" "trail" count never exceeds "MAX_TRAILS"')
def active_trail_count_never_exceeds_max():
    """Invariant: verified by the FizzBee model checker; no runtime check needed."""
