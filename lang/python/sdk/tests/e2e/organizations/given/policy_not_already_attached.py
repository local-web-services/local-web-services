"""Given: the policy is not already attached to the target"""

from __future__ import annotations

from pytest_bdd import given


@given("the policy is not already attached to the target")
def policy_not_already_attached():
    """No-op: fresh state has no policy attachments."""
