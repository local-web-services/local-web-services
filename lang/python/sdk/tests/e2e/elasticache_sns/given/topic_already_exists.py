"""Given: the "sns" "topic" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheSnsTestClient


@given('the "sns" "topic" already existed')
def topic_already_exists(lws_session):
    ElasticacheSnsTestClient(lws_session).create_topic()
