"""Given: function_is_deleted_given"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient
from ..constants import TEST_FUNC


@given('the "lambda" "function" was "DELETED"')
def function_is_deleted_given(lws_session):
    LambdaTestClient(lws_session).create_function()
    lws_session.lifecycle("lambda").delete_dwell_ms(0).apply()
    lws_session.client("lambda").delete_function(FunctionName=TEST_FUNC)
