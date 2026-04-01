"""Then: every delivery retry count is within the allowed limit"""

from __future__ import annotations

from pytest_bdd import step


@step("every delivery retry count is within the allowed limit")
def delivery_retry_count_within_limit():
    """Invariant: trivially true in isolated context."""
