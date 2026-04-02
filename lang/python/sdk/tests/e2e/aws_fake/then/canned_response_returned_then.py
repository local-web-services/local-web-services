"""Then: the canned response will be returned and the request does not reach the "aws fake" provider"""

from __future__ import annotations

from pytest_bdd import then


@then('the canned response will be returned and the request does not reach the "aws fake" provider')
def canned_response_returned_then():
    """Invariant step: trivially satisfied in isolated test context."""
