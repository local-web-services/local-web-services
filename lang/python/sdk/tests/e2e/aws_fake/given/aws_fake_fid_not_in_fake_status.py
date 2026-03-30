"""Given: fid not in fake_status"""

from __future__ import annotations

from pytest_bdd import given


@given("fid not in fake_status")
def aws_fake_fid_not_in_fake_status():
    """No-op: fresh state has no AWS fakes."""
