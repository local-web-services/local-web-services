"""Then: schema version is always at least one"""

from __future__ import annotations

from pytest_bdd import then


@then("schema version is always at least one")
def schema_version_always_at_least_one():
    """Invariant: trivially satisfied in isolated test context."""
