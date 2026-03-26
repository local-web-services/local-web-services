"""Given: fid in callee_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLEE


@given("fid in callee_status")
def fid_in_callee_status(lws_session):
    LambdaLambdaTestClient(lws_session).create_function(TEST_CALLEE)
