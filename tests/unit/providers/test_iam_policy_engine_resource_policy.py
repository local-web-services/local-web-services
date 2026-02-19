"""Unit tests for resource policy evaluation in iam_policy_engine."""

from __future__ import annotations

from lws.providers._shared.iam_policy_engine import (
    Decision,
    EvaluationContext,
    evaluate,
)


class TestEvaluateResourcePolicy:
    def test_resource_policy_allows(self):
        # Arrange
        context = EvaluationContext(
            principal="user1",
            actions=["s3:GetObject"],
            resource="*",
            identity_policies=[],
            resource_policy={
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Effect": "Allow",
                        "Principal": "*",
                        "Action": "s3:GetObject",
                        "Resource": "*",
                    }
                ],
            },
        )

        # Act
        actual_decision, actual_reason = evaluate(context)

        # Assert
        assert actual_decision == Decision.ALLOW
        expected_reason = "Resource policy Allow"
        assert actual_reason == expected_reason
