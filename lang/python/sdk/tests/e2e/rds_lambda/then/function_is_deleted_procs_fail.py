"""Then: the "lambda" "function" will be deleted and stored procedure invocations targeting it will fail"""

from __future__ import annotations

from pytest_bdd import then

from ..client import RdsLambdaTestClient


@then(
    'the "lambda" "function" will be deleted and stored procedure invocations targeting it will fail'
)
def function_is_deleted_procs_fail(lws_session):
    expected_exists = False
    actual_exists = RdsLambdaTestClient(lws_session).get_function_exists()
    assert actual_exists == expected_exists, "Expected function to be deleted but it still exists"
