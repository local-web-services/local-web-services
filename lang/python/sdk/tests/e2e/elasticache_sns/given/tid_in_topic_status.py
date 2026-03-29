"""Given: tid in topic_status"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import ElasticacheSnsTestClient


@given("tid in topic_status")
def tid_in_topic_status(lws_session):
    try:
        ElasticacheSnsTestClient(lws_session).create_topic()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "TopicAlreadyExists":
            raise
