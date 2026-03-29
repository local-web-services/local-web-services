"""Given: the condition is not satisfied"""

from __future__ import annotations

from pytest_bdd import given


@given("the condition is not satisfied")
def condition_is_not_satisfied():
    """No-op: empty table means condition on existing item is not satisfied."""
