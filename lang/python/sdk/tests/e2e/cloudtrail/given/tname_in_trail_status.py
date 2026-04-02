"""Given: tname in trail_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("tname in trail_status")
def tname_in_trail_status(lws_session, world):
    client = CloudtrailTestClient(lws_session)
    client.create_trail()
    world["tname_in_trail_status"] = True
