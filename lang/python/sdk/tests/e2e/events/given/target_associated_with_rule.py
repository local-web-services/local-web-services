"""Given: a target is associated with the rule"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("a target is associated with the rule")
def target_associated_with_rule(lws_session):
    EventsTestClient(lws_session).put_target()
