"""Then: the parameter has a new value and an incremented version"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM, INT_VALUE2


@then("the parameter has a new value and an incremented version")
def parameter_has_new_value_and_version(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.GetParameter"},
        json={"Name": INT_PARAM},
    )
    param = r.json()["Parameter"]
    expected_value = INT_VALUE2
    actual_value = param["Value"]
    assert (
        actual_value == expected_value
    ), f"Expected parameter value '{expected_value}' but got '{actual_value}'"
    actual_version = param["Version"]
    assert actual_version >= 2, f"Expected version >= 2 after overwrite but got: {actual_version}"
