"""Given: the target function was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient
from ..constants import TEST_FUNC


@given('the "lambda" "function" was not "ACTIVE"')
def events_lambda_function_is_not_active_given(lws_session, world):
    try:
        lws_session.client("lambda").delete_function(FunctionName=TEST_FUNC)
    except Exception:
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    EventsLambdaTestClient(lws_session).create_function()
    world["result"] = None
    world["error"] = None
