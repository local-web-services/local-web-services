"""Given: pname not in param_exists or param_exists[pname] is False"""

from __future__ import annotations

from pytest_bdd import given


@given("pname not in param_exists or param_exists[pname] is False")
def ssm_pname_not_in_param_exists():
    """No-op: fresh state has no parameters."""
