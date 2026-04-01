"""Given: no trail is in logging state"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("no trail is in logging state")
def no_trail_is_in_logging_state(lws_session):
    CloudtrailTestClient(lws_session).stop_logging()
