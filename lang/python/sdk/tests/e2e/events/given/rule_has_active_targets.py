"""Given: the rule has active targets"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("the rule has active targets")
def rule_has_active_targets(lws_session):
    """Add a target to the rule so it has active targets."""
    EventsTestClient(lws_session).put_target()
