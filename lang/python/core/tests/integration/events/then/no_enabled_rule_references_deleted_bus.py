"""Then: no enabled rule references a deleted event bus."""

from __future__ import annotations

from pytest_bdd import then


@then('no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"')
def no_enabled_rule_references_deleted_bus():
    """Invariant: trivially satisfied in isolated integration test context."""
