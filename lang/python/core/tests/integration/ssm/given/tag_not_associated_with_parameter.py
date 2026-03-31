"""Given: the tag was not associated with the "ssm" "parameter" """

from __future__ import annotations

from pytest_bdd import given


@given('the tag was not associated with the "ssm" "parameter"')
def tag_not_associated_with_parameter():
    """No-op: fresh state has no tags associated with the parameter."""
