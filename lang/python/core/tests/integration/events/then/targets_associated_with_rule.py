"""Then: the targets are associated with the rule."""

from __future__ import annotations

from pytest_bdd import then


@then("the targets are associated with the rule")
def targets_associated_with_rule(world):
    assert world["error"] is None, f"Expected put_targets to succeed but got: {world['error']}"
