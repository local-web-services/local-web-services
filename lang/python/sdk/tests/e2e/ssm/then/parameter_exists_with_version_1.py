"""Then: the "ssm" "parameter" will exist with version 1"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_PARAM


@then('the "ssm" "parameter" will exist with version 1')
def parameter_exists_with_version_1(lws_session):
    resp = lws_session.client("ssm").get_parameter(Name=TEST_PARAM)
    expected_version = 1
    actual_version = resp["Parameter"]["Version"]
    assert (
        actual_version == expected_version
    ), f"Expected parameter version '{expected_version}' but got '{actual_version}'"
