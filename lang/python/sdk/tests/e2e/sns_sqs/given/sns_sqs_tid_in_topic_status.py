"""Given: tid in topic_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient


@given("tid in topic_status")
def sns_sqs_tid_in_topic_status(lws_session):
    SnsSqsTestClient(lws_session).create_topic()
