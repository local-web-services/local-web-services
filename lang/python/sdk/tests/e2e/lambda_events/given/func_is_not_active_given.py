"""Given: the function is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaEventsTestClient
from ..constants import TEST_FUNC


@given('the function is not "ACTIVE"')
def func_is_not_active_given(lws_session, world):
    try:
        LambdaEventsTestClient(lws_session)._lambda.delete_function(FunctionName=TEST_FUNC)
    except Exception:
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    LambdaEventsTestClient(lws_session).create_function()
    world["result"] = None
    world["error"] = None
