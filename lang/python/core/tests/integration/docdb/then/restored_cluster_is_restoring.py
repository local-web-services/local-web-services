"""Then: the restored cluster is in "RESTORING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the restored cluster is in "RESTORING" state')
def restored_cluster_is_restoring(client: TestClient, world):
    # Arrange
    expected_error = None
    expected_status = "restoring"

    # Act
    actual_error = world["error"]
    actual_status = world["result"].get("DBCluster", {}).get("Status", "")

    # Assert
    assert (
        actual_error is expected_error
    ), f"Expected cluster restore to succeed but got: {actual_error}"
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}"
