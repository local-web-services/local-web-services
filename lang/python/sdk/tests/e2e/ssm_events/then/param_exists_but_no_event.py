"""Then: the parameter will exist but no event will be delivered"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_PARAM, TEST_VALUE


@then("the parameter will exist but no event will be delivered")
def param_exists_but_no_event(lws_session):
    resp = lws_session.client("ssm").get_parameter(Name=TEST_PARAM)
    actual_value = resp["Parameter"]["Value"]
    assert (
        actual_value == TEST_VALUE
    ), f"Expected parameter value '{TEST_VALUE}' but got: {actual_value}"
