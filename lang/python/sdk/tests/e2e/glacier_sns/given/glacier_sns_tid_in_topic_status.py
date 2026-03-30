"""Given: tid in topic_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given("tid in topic_status")
def glacier_sns_tid_in_topic_status(lws_session):
    GlacierSnsTestClient(lws_session).create_topic()
