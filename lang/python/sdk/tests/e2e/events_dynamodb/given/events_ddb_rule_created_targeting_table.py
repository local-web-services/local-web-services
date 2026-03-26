"""Given: an EventBridge rule has been created targeting a DynamoDB table"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("an EventBridge rule has been created targeting a DynamoDB table")
def events_ddb_rule_created_targeting_table(lws_session):
    EventsDynamodbTestClient(lws_session).create_rule()
