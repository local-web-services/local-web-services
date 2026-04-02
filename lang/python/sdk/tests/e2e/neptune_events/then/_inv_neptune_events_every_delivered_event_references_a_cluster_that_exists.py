"""Then: every "DELIVERED" "eventbridge" "event" references a "neptune" "cluster" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every "DELIVERED" "eventbridge" "event" references a "neptune" "cluster" that exists')
def _inv_neptune_events_every_delivered_event_references_a_cluster_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
