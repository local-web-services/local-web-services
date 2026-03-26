"""Then: the parameter "EXISTS" """

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsSsmTestClient
from ..constants import TEST_PARAM, TEST_VALUE


@then('the parameter "EXISTS"')
def param_exists_then(lws_session):
    resp = StepfunctionsSsmTestClient(lws_session)._ssm.get_parameter(Name=TEST_PARAM)
    actual_value = resp["Parameter"]["Value"]
    assert (
        actual_value == TEST_VALUE
    ), f"Expected parameter value '{TEST_VALUE}' but got: {actual_value}"
