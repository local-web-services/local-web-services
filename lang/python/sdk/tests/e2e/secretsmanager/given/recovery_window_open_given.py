"""Given: the "secrets manager" "secret" recovery window was open"""

from __future__ import annotations

from pytest_bdd import given


@given('the "secrets manager" "secret" recovery window was open')
def recovery_window_open_given():
    """No-op: after deletion, recovery window is always open initially."""
