"""Then: the function is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaStepfunctionsTestClient
from ..constants import TEST_FUNC


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = LambdaStepfunctionsTestClient(lws_session)._lambda.get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"
