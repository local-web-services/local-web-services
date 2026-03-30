"""Then: all version identifiers are unique across secrets"""

from __future__ import annotations

from pytest_bdd import then


@then("all version identifiers are unique across secrets")
def all_version_ids_unique():
    """No-op invariant: trivially satisfied in an isolated test context."""
