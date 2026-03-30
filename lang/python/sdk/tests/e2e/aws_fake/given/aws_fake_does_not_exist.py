"""Given: the "AWS" fake does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "AWS" fake does not exist')
def aws_fake_does_not_exist():
    """No-op: fresh state has no AWS fakes."""
