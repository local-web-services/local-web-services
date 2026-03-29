"""Then: the snapshot is "DELETED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the snapshot is "DELETED"')
def snapshot_is_deleted(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected snapshot deletion to succeed but got: {actual_error}"
