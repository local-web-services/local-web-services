"""Given: the "AWS" fake was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "AWS" fake was "ACTIVE"')
def aws_fake_is_active():
    """No-op: aws_fake_exists already created the fake in ACTIVE state."""
