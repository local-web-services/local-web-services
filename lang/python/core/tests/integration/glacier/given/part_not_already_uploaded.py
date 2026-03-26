"""Given: the part has not already been uploaded"""

from __future__ import annotations

from pytest_bdd import given


@given("the part has not already been uploaded")
def part_not_already_uploaded():
    """No-op: fresh upload has no parts."""
