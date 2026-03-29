"""Given: an "SNS" topic has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given('an "SNS" topic has been created')
def glacier_sns_seq_topic_created(lws_session):
    GlacierSnsTestClient(lws_session).create_topic()
