"""Unit tests for boundary policy evaluation in iam_policy_engine."""

from __future__ import annotations

from lws.providers._shared.iam_policy_engine import (
    Decision,
    EvaluationContext,
    evaluate,
)


class TestEvaluateBoundary:
    def test_boundary_denies_outside_actions(self):
        # Arrange
        context = EvaluationContext(
            principal="user1",
            actions=["s3:DeleteBucket"],
            resource="*",
            identity_policies=[
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {"Effect": "Allow", "Action": "*", "Resource": "*"},
                    ],
                }
            ],
            boundary_policy={
                "Version": "2012-10-17",
                "Statement": [
                    {"Effect": "Allow", "Action": "s3:GetObject", "Resource": "*"},
                ],
            },
        )

        # Act
        actual_decision, actual_reason = evaluate(context)

        # Assert
        assert actual_decision == Decision.DENY
        expected_reason = "Not allowed by permissions boundary"
        assert actual_reason == expected_reason
