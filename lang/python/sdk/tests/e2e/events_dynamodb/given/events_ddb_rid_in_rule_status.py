"""Given: rid in rule_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("rid in rule_status")
def events_ddb_rid_in_rule_status(lws_session):
    EventsDynamodbTestClient(lws_session).create_rule()
