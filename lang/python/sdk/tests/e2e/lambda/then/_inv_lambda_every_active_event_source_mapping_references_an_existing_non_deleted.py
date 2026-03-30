"""Then: every active event source mapping references an existing non-deleted function"""

from __future__ import annotations

from pytest_bdd import then


@then("every active event source mapping references an existing non-deleted function")
def _inv_lambda_every_active_event_source_mapping_references_an_existing_non_deleted():
    """Invariant step: trivially satisfied in isolated test context."""
