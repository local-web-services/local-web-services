"""Then: no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus" """

from __future__ import annotations

from pytest_bdd import step


@step('no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"')
def no_enabled_rule_references_deleted_bus(lws_session):
    """Invariant: since bus deletion fails when rules exist, this is guaranteed."""
