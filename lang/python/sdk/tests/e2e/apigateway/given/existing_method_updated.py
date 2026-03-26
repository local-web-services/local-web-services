"""Given: an existing method has been updated"""

from __future__ import annotations

from pytest_bdd import given


@given("an existing method has been updated")
def existing_method_updated():
    """No-op: method update is part of API setup in the test."""
