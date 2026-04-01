"""Given: pid not in param_status"""

from __future__ import annotations

from pytest_bdd import given


@given("pid not in param_status")
def pid_not_in_param_status():
    """No-op: fresh state has no parameters."""
