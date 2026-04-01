"""Given: the "organizations" "policy" was not already attached to the "organizations" "target" """

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "policy" was not already attached to the "organizations" "target"')
def policy_not_already_attached():
    """No-op: fresh state has no policy attachments."""
