"""Given: the "AWS" fake is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "AWS" fake is "ACTIVE"')
def aws_fake_is_active():
    """No-op: aws_fake_exists already created the fake in ACTIVE state."""
