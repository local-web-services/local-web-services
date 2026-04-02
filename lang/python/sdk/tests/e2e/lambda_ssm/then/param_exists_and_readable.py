"""Then: the "ssm" "parameter" will exist and can be read by "lambda" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_PARAM, TEST_PARAM_VALUE


@then('the "ssm" "parameter" will exist and can be read by "lambda"')
def param_exists_and_readable(lws_session):
    resp = lws_session.client("ssm").get_parameter(Name=TEST_PARAM)
    actual_value = resp["Parameter"]["Value"]
    expected_value = TEST_PARAM_VALUE
    assert (
        actual_value == expected_value
    ), f"Expected parameter value '{expected_value}' but got '{actual_value}'"
