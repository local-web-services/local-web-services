"""Test client for sns tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_TOPIC


class SnsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("sns")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_topic(self, name=TEST_TOPIC):
        try:
            resp = self._client.create_topic(Name=name)
            return resp["TopicArn"]
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "TopicAlreadyExists":
                return self.get_topic_arn(name)
            raise

    def get_topic_arn(self, name=TEST_TOPIC):
        return f"arn:aws:sns:us-east-1:000000000000:{name}"
