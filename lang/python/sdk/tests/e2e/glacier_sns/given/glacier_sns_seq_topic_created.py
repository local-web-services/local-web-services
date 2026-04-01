"""Given: a "sns" "topic" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given('a "sns" "topic" is created')
def glacier_sns_seq_topic_created(lws_session):
    GlacierSnsTestClient(lws_session).create_topic()
