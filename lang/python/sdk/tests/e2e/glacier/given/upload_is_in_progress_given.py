"""Given: the upload is InProgress"""

from __future__ import annotations

from pytest_bdd import given


@given("the upload is InProgress")
def upload_is_in_progress_given():
    """No-op: a freshly initiated upload is InProgress by default."""
