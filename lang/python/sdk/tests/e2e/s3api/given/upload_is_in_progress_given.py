"""Given: the upload is "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import given


@given('the upload is "IN_PROGRESS"')
def upload_is_in_progress_given(world):
    """No-op: upload was already created in the upload_exists step."""
