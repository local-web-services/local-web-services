"""Given: the "aws fake" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "aws fake" did not already exist')
def aws_fake_not_already_exist():
    """No-op: fresh state has no AWS fakes."""
