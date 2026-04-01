"""Given: the "api gateway" "method" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "method" did not already exist')
def the_method_does_not_already_exist():
    """No-op: fresh state has no methods."""
