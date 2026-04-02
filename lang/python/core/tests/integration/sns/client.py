"""Test client for sns tests."""

from __future__ import annotations

from .constants import TEST_EMAIL_ENDPOINT, TEST_TOPIC, _extract_xml_tag


class SnsTestClient:
    def __init__(self, client):
        self._client = client

    def create_topic(self, name: str = TEST_TOPIC) -> str:
        r = self._client.post("/", data={"Action": "CreateTopic", "Name": name})
        assert r.status_code == 200, f"Expected {200!r} but got {r.status_code!r}"
        return _extract_xml_tag(r.text, "TopicArn")

    def subscribe(
        self,
        topic_arn: str,
        protocol: str = "email",
        endpoint: str = TEST_EMAIL_ENDPOINT,
    ) -> str:
        r = self._client.post(
            "/",
            data={
                "Action": "Subscribe",
                "TopicArn": topic_arn,
                "Protocol": protocol,
                "Endpoint": endpoint,
            },
        )
        assert r.status_code == 200, f"Expected {200!r} but got {r.status_code!r}"
        return _extract_xml_tag(r.text, "SubscriptionArn")
