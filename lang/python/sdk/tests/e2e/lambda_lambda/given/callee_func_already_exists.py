"""Given: the callee "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLEE


@given('the callee "lambda" "function" already existed')
def callee_func_already_exists(lws_session):
    LambdaLambdaTestClient(lws_session).create_function(TEST_CALLEE)
