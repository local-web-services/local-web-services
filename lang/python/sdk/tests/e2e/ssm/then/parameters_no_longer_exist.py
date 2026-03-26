"""Then: the parameters no longer exist"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_PARAM


@then("the parameters no longer exist")
def parameters_no_longer_exist(lws_session):
    resp = lws_session.client("ssm").describe_parameters()
    actual_names = [p["Name"] for p in resp.get("Parameters", [])]
    assert (
        TEST_PARAM not in actual_names
    ), f"Expected parameter '{TEST_PARAM}' to be deleted but found in: {actual_names}"
