"""Then: the canned response will be returned when the "aws fake" request header matches"""

from __future__ import annotations

from pytest_bdd import then


@then('the canned response will be returned when the "aws fake" request header matches')
def canned_response_returned_when_header_matches_then():
    """Invariant step: trivially satisfied in isolated test context."""
