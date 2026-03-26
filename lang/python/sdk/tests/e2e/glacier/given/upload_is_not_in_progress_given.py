"""Given: the upload is not InProgress"""

from __future__ import annotations

from pytest_bdd import given


@given("the upload is not InProgress")
def upload_is_not_in_progress_given():
    """No-op: fresh state has no in-progress uploads."""
