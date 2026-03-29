"""Then: the parameter exists with version 1"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM


@then("the parameter exists with version 1")
def parameter_exists_with_version_1(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.GetParameter"},
        json={"Name": INT_PARAM},
    )
    expected_version = 1
    actual_version = r.json()["Parameter"]["Version"]
    assert (
        actual_version == expected_version
    ), f"Expected parameter version '{expected_version}' but got '{actual_version}'"
