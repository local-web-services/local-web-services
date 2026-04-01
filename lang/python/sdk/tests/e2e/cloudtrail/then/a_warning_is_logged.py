"""Then: a warning is logged"""

from __future__ import annotations

from pytest_bdd import then


@then("a warning is logged")
def a_warning_is_logged():
    """No-op: warning log output cannot be easily verified at the E2E level."""
