"""Given: the callee is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLEE


@given('the callee is already "DELETED"')
def callee_is_already_deleted(lws_session, world):
    try:
        LambdaLambdaTestClient(lws_session).create_function(TEST_CALLEE)
    except Exception:
        pass
    lws_session.lifecycle("lambda").delete_dwell_ms(5000).apply()
    try:
        LambdaLambdaTestClient(lws_session).delete_function(FunctionName=TEST_CALLEE)
    except Exception:
        pass
    world["result"] = None
    world["error"] = None
