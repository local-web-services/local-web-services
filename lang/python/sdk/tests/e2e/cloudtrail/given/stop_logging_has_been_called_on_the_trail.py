"""Given: StopLogging has been called on the trail"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("StopLogging has been called on the trail")
def stop_logging_has_been_called_on_the_trail(lws_session):
    CloudtrailTestClient(lws_session).stop_logging()
