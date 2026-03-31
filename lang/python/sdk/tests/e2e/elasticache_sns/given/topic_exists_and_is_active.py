"""Given: the "sns" "topic" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheSnsTestClient


@given('the "sns" "topic" existed and was "ACTIVE"')
def topic_exists_and_is_active(lws_session):
    ElasticacheSnsTestClient(lws_session).create_topic()
