"""Then: the parameter has a new value and an incremented version"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SsmTestClient
from ..constants import TEST_PARAM, TEST_VALUE2


@then("the parameter has a new value and an incremented version")
def parameter_has_new_value_and_version(lws_session):
    resp = SsmTestClient(lws_session).get_parameter(Name=TEST_PARAM)
    expected_value = TEST_VALUE2
    actual_value = resp["Parameter"]["Value"]
    assert (
        actual_value == expected_value
    ), f"Expected parameter value '{expected_value}' but got '{actual_value}'"
    actual_version = resp["Parameter"]["Version"]
    assert actual_version >= 2, f"Expected version >= 2 after overwrite but got: {actual_version}"
