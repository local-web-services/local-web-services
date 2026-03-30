"""Then: the parameter "EXISTS" but no event is delivered"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_PARAM, TEST_VALUE


@then('the parameter "EXISTS" but no event is delivered')
def param_exists_but_no_event(lws_session):
    resp = lws_session.client("ssm").get_parameter(Name=TEST_PARAM)
    actual_value = resp["Parameter"]["Value"]
    assert (
        actual_value == TEST_VALUE
    ), f"Expected parameter value '{TEST_VALUE}' but got: {actual_value}"
