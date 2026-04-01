"""Given: StartLogging is called"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("StartLogging is called")
def start_logging_is_called(lws_session):
    CloudtrailTestClient(lws_session).start_logging()
