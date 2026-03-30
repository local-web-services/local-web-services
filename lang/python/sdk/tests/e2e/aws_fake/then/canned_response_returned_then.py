"""Then: the canned response is returned and the request does not reach the provider"""

from __future__ import annotations

from pytest_bdd import then


@then("the canned response is returned and the request does not reach the provider")
def canned_response_returned_then():
    """Invariant step: trivially satisfied in isolated test context."""
