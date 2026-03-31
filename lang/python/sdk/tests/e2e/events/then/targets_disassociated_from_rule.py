"""Then: the targets are disassociated from the "eventbridge" "rule" """

from __future__ import annotations

from pytest_bdd import then


@then('the targets are disassociated from the "eventbridge" "rule"')
def targets_disassociated_from_rule(world):
    assert world["error"] is None, f"Expected remove_targets to succeed but got: {world['error']}"
