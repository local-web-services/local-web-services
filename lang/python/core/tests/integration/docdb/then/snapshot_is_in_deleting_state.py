"""Then: the snapshot is in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the snapshot is in "DELETING" state')
def snapshot_is_in_deleting_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected snapshot deletion to succeed but got: {actual_error}"
