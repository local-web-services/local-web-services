"""Given: the caller "lambda" "function" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLER


@given('the caller "lambda" "function" was not "ACTIVE"')
def caller_is_not_active_given(lws_session, world):
    try:
        LambdaLambdaTestClient(lws_session).delete_function(FunctionName=TEST_CALLER)
    except Exception:
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    LambdaLambdaTestClient(lws_session).create_function(TEST_CALLER)
    world["result"] = None
    world["error"] = None
