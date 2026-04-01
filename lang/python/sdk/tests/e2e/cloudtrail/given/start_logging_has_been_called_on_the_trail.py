"""Given: StartLogging has been called on the trail"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("StartLogging has been called on the trail")
def start_logging_has_been_called_on_the_trail(lws_session):
    CloudtrailTestClient(lws_session).start_logging()
