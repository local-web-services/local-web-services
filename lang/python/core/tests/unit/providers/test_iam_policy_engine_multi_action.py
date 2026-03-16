"""Unit tests for multi-action evaluation in iam_policy_engine."""

from __future__ import annotations

from lws.providers._shared.iam_policy_engine import (
    Decision,
    EvaluationContext,
    evaluate,
)


class TestEvaluateMultiAction:
    def test_all_actions_must_be_allowed(self):
        # Arrange
        context = EvaluationContext(
            principal="user1",
            actions=["s3:GetObject", "s3:PutObject"],
            resource="*",
            identity_policies=[
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {"Effect": "Allow", "Action": "s3:GetObject", "Resource": "*"},
                    ],
                }
            ],
        )

        # Act
        actual_decision, actual_reason = evaluate(context)

        # Assert
        assert actual_decision == Decision.DENY
        expected_reason = "Implicit Deny"
        assert actual_reason == expected_reason

    def test_wildcard_allows_all_actions(self):
        # Arrange
        context = EvaluationContext(
            principal="user1",
            actions=["s3:GetObject", "s3:PutObject"],
            resource="*",
            identity_policies=[
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {"Effect": "Allow", "Action": "*", "Resource": "*"},
                    ],
                }
            ],
        )

        # Act
        actual_decision, actual_reason = evaluate(context)

        # Assert
        assert actual_decision == Decision.ALLOW
