"""Given: an "SNS" topic has been created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import ElasticacheSnsTestClient


@given('an "SNS" topic has been created')
def elasticache_sns_topic_has_been_created(lws_session):
    try:
        ElasticacheSnsTestClient(lws_session).create_topic()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "TopicAlreadyExists":
            raise
