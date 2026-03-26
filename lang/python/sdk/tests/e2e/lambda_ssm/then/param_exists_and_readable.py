"""Then: the parameter "EXISTS" and can be read by Lambda"""

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaSsmTestClient
from ..constants import TEST_PARAM, TEST_PARAM_VALUE


@then('the parameter "EXISTS" and can be read by Lambda')
def param_exists_and_readable(lws_session):
    resp = LambdaSsmTestClient(lws_session)._ssm.get_parameter(Name=TEST_PARAM)
    actual_value = resp["Parameter"]["Value"]
    expected_value = TEST_PARAM_VALUE
    assert (
        actual_value == expected_value
    ), f"Expected parameter value '{expected_value}' but got '{actual_value}'"
