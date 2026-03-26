"""Given: the tag is not associated with the parameter"""

from __future__ import annotations

from pytest_bdd import given


@given("the tag is not associated with the parameter")
def tag_not_associated_with_parameter():
    """No-op: fresh state has no tags associated with the parameter."""
