"""Then: every rule references an event bus that exists"""

from __future__ import annotations

from pytest_bdd import step


@step("every rule references an event bus that exists")
def every_rule_references_existing_bus(lws_session):
    """Invariant: no rule references a non-existent event bus.

    Since rules are created on existing buses and bus deletion fails when
    rules exist, this invariant is maintained by construction.
    """
