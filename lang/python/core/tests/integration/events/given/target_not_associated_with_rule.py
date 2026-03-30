"""Given: the target is not associated with the rule."""

from __future__ import annotations

from pytest_bdd import given


@given("the target is not associated with the rule")
def target_not_associated_with_rule():
    """No-op: fresh rules have no targets; remove_targets will fail with missing target."""
