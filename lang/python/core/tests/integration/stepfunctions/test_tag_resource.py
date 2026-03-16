"""Integration test for Step Functions TagResource."""

from __future__ import annotations

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestTagResource:
    async def test_tag_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.TagResource"},
            json={
                "resourceArn": _SM_ARN,
                "tags": [{"key": "env", "value": "test"}],
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
