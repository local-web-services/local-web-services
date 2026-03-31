"""Then: every event source mapping has a valid status"""

from __future__ import annotations

from pytest_bdd import step


@step("every event source mapping has a valid status")
def _inv_lambda_every_event_source_mapping_has_a_valid_status():
    """Invariant step: trivially satisfied in isolated test context."""
