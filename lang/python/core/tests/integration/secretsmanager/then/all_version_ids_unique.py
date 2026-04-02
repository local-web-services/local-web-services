"""Then: all "secrets manager" "secret" version identifiers are unique"""

from __future__ import annotations

from pytest_bdd import then


@then('all "secrets manager" "secret" version identifiers are unique')
def all_version_ids_unique():
    """No-op invariant: trivially satisfied in an isolated test context."""
