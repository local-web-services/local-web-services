"""Unit tests for explicit deny evaluation in iam_policy_engine."""

from __future__ import annotations

from lws.providers._shared.iam_policy_engine import (
    Decision,
    EvaluationContext,
    evaluate,
)


class TestEvaluateExplicitDeny:
    def test_explicit_deny_overrides_allow(self):
        # Arrange
        context = EvaluationContext(
            principal="user1",
            actions=["s3:GetObject"],
            resource="*",
            identity_policies=[
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {"Effect": "Allow", "Action": "*", "Resource": "*"},
                        {"Effect": "Deny", "Action": "s3:GetObject", "Resource": "*"},
                    ],
                }
            ],
        )

        # Act
        actual_decision, actual_reason = evaluate(context)

        # Assert
        assert actual_decision == Decision.DENY
        expected_reason = "Explicit Deny"
        assert actual_reason == expected_reason
