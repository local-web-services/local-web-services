"""Integration test for Step Functions UntagResource."""

from __future__ import annotations

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestUntagResource:
    async def test_untag_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.TagResource"},
            json={"resourceArn": _SM_ARN, "tags": [{"key": "env", "value": "test"}]},
        )

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.UntagResource"},
            json={
                "resourceArn": _SM_ARN,
                "tagKeys": ["env"],
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
