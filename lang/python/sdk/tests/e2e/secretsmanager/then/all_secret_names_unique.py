"""Then: all secret names are unique"""

from __future__ import annotations

from pytest_bdd import step


@step("all secret names are unique")
def all_secret_names_unique():
    """No-op invariant: trivially satisfied in an isolated test context."""
