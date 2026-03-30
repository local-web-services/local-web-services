"""Given: the recovery window is open"""

from __future__ import annotations

from pytest_bdd import given


@given("the recovery window is open")
def recovery_window_open_given():
    """No-op: after deletion, recovery window is always open initially."""
