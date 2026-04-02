"""Given: the active trail count is below the maximum (5)"""

from __future__ import annotations

from pytest_bdd import given


@given("the active trail count is below the maximum (5)")
@given('the "cloudtrail" "trail" count is below the maximum (5)')
def the_active_trail_count_is_below_the_maximum():
    """No-op: reset ensures no trails exist, so count is zero."""
