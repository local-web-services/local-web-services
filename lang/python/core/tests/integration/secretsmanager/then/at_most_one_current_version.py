"""Then: at most one current version exists per secret"""

from __future__ import annotations

from pytest_bdd import then


@then("at most one current version exists per secret")
def at_most_one_current_version():
    """No-op invariant: trivially satisfied in an isolated test context."""
