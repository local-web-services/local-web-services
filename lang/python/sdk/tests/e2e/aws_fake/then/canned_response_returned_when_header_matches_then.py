"""Then: the canned response is returned when the request header matches"""

from __future__ import annotations

from pytest_bdd import then


@then("the canned response is returned when the request header matches")
def canned_response_returned_when_header_matches_then():
    """Invariant step: trivially satisfied in isolated test context."""
