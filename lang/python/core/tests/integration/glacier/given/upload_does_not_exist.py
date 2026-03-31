"""Given: the "glacier" "upload" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "upload" did not exist')
def upload_does_not_exist(world):
    world["upload_id"] = "nonexistent-upload-id"
