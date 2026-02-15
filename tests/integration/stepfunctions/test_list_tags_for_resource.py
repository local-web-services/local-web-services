"""Integration test for Step Functions ListTagsForResource."""

from __future__ import annotations

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestListTagsForResource:
    async def test_list_tags_for_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.ListTagsForResource"},
            json={"resourceArn": _SM_ARN},
        )

        # Assert
        assert resp.status_code == expected_status_code
