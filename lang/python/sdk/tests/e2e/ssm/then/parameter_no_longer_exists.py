"""Then: the parameter no longer exists"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SsmTestClient
from ..constants import TEST_PARAM


@then("the parameter no longer exists")
def parameter_no_longer_exists(lws_session):
    resp = SsmTestClient(lws_session).describe_parameters()
    actual_names = [p["Name"] for p in resp.get("Parameters", [])]
    assert (
        TEST_PARAM not in actual_names
    ), f"Expected parameter '{TEST_PARAM}' to be deleted but found in: {actual_names}"
