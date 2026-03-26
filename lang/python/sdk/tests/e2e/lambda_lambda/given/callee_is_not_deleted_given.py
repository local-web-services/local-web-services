"""Given: the callee is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLEE


@given('the callee is not "DELETED"')
def callee_is_not_deleted_given(lws_session):
    LambdaLambdaTestClient(lws_session).create_function(TEST_CALLEE)
