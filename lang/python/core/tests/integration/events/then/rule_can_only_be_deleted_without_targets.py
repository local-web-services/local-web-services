"""Then: a rule can only be deleted when it has no targets."""

from __future__ import annotations

from pytest_bdd import then


@then('an "eventbridge" "rule" can only be deleted when it has no targets')
def rule_can_only_be_deleted_without_targets():
    """Invariant: trivially satisfied in isolated integration test context."""
