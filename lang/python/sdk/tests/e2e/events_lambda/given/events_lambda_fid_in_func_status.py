"""Given: fid in func_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given("fid in func_status")
def events_lambda_fid_in_func_status(lws_session):
    EventsLambdaTestClient(lws_session).create_function()
