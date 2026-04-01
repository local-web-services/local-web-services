"""Given: a "sns" "topic" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given('a "sns" "topic" is created')
def events_sns_seq_topic_created(lws_session):
    EventsSnsTestClient(lws_session).create_topic()
