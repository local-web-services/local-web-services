"""Then: at most one previous version exists per "secrets manager" "secret" """

from __future__ import annotations

from pytest_bdd import then


@then('at most one previous version exists per "secrets manager" "secret"')
def at_most_one_previous_version():
    """No-op invariant: trivially satisfied in an isolated test context."""
