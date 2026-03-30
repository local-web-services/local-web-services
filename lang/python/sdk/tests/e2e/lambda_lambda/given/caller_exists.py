"""Given: the caller exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLER


@given("the caller exists")
def caller_exists(lws_session):
    LambdaLambdaTestClient(lws_session).create_function(TEST_CALLER)
