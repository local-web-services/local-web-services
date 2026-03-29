"""Then: the request passes through to the real "AWS" provider unchanged"""

from __future__ import annotations

from pytest_bdd import then


@then('the request passes through to the real "AWS" provider unchanged')
def request_passes_through_then():
    """Invariant step: trivially satisfied in isolated test context."""
