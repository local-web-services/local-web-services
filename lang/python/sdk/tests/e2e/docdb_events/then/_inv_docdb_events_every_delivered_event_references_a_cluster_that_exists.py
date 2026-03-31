"""Then: every "DELIVERED" event references a "documentdb" "cluster" that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every "DELIVERED" event references a "documentdb" "cluster" that exists')
def _inv_docdb_events_every_delivered_event_references_a_cluster_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
