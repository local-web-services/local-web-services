"""Given: the "cloudformation" "stack" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cloudformation" "stack" did not exist')
def stack_did_not_exist(world):
    """Signal that the stack does not exist so guard-aware When steps can reject."""
    world["stack_exists"] = False
