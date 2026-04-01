"""Given: function_is_not_active_given"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient
from ..constants import TEST_FUNC


@given('the "lambda" "function" was not "ACTIVE"')
def function_is_not_active_given(lws_session, world):
    try:
        LambdaTestClient(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    LambdaTestClient(lws_session).create_function()
    world["result"] = None
    world["error"] = None
