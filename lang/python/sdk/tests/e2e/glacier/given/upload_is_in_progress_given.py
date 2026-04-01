"""Given: the "glacier" "upload" was "InProgress" """

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "upload" was "InProgress"')
def upload_is_in_progress_given():
    """No-op: a freshly initiated upload is InProgress by default."""
