"""Given: the callee "lambda" "function" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLEE


@given('the callee "lambda" "function" was "ACTIVE"')
def callee_is_active_given(lws_session):
    try:
        LambdaLambdaTestClient(lws_session).create_function(TEST_CALLEE)
    except Exception:
        pass
