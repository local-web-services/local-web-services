"""Unit tests for identity policy evaluation in iam_policy_engine."""

from __future__ import annotations

from lws.providers._shared.iam_policy_engine import (
    Decision,
    EvaluationContext,
    evaluate,
)


class TestEvaluateIdentityPolicy:
    def test_identity_policy_allows(self):
        # Arrange
        context = EvaluationContext(
            principal="user1",
            actions=["dynamodb:GetItem"],
            resource="*",
            identity_policies=[
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {"Effect": "Allow", "Action": "dynamodb:GetItem", "Resource": "*"},
                    ],
                }
            ],
        )

        # Act
        actual_decision, actual_reason = evaluate(context)

        # Assert
        assert actual_decision == Decision.ALLOW
        expected_reason = "Identity policy Allow"
        assert actual_reason == expected_reason

    def test_implicit_deny(self):
        # Arrange
        context = EvaluationContext(
            principal="user1",
            actions=["dynamodb:PutItem"],
            resource="*",
            identity_policies=[
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {"Effect": "Allow", "Action": "dynamodb:GetItem", "Resource": "*"},
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
