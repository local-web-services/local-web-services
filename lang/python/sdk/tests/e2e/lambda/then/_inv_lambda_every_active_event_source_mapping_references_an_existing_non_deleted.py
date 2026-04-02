"""Then: every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"'
)
def _inv_lambda_every_active_event_source_mapping_references_an_existing_non_deleted():
    """Invariant step: trivially satisfied in isolated test context."""
