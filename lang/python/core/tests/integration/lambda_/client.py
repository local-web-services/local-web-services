"""Test client for lambda_ tests."""

from __future__ import annotations

from .constants import INT_ESM_SOURCE_ARN, INT_FUNCTION_NAME, INT_ROLE_ARN


class LambdaTestClient:
    def __init__(self, client):
        self._client = client

    def create_function(self, name: str = INT_FUNCTION_NAME) -> None:
        return self._client.post(
            "/2015-03-31/functions",
            json={
                "FunctionName": name,
                "Runtime": "python3.12",
                "Role": INT_ROLE_ARN,
                "Handler": "index.handler",
                "Code": {"ZipFile": ""},
            },
        )

    def create_esm(
        self,
        function_name: str = INT_FUNCTION_NAME,
        source_arn: str = INT_ESM_SOURCE_ARN,
    ) -> None:
        return self._client.post(
            "/2015-03-31/event-source-mappings",
            json={"FunctionName": function_name, "EventSourceArn": source_arn},
        )

    def get_esm_uuid(self, function_name: str = INT_FUNCTION_NAME) -> str:
        r = self._client.get("/2015-03-31/event-source-mappings")
        mappings = r.json().get("EventSourceMappings", [])
        for m in mappings:
            if m.get("FunctionArn", "").endswith(function_name):
                return m["UUID"]
        return ""
