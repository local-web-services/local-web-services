"""Given: the caller "lambda" "function" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLER


@given('the caller "lambda" "function" existed')
def caller_exists(lws_session):
    LambdaLambdaTestClient(lws_session).create_function(TEST_CALLER)
