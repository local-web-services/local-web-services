"""Given: an "eventbridge" "rule" is created targeting a "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given('an "eventbridge" "rule" is created targeting a "dynamodb" "table"')
def events_ddb_rule_created_targeting_table(lws_session):
    EventsDynamodbTestClient(lws_session).create_rule()
