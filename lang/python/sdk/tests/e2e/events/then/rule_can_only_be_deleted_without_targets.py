"""Then: a rule can only be deleted when it has no targets"""

from __future__ import annotations

from pytest_bdd import then


@then("a rule can only be deleted when it has no targets")
def rule_can_only_be_deleted_without_targets(lws_session):
    """Invariant: the provider enforces that rules with targets cannot be deleted.

    This is verified by the delete_rule negative scenario; here we just
    confirm the invariant is modelled (no-op check).
    """
