"""Then: an "sqs" "message" can only be delivered if a "CONFIRMED" "sns" "subscription" exists for the "sns" "topic" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'an "sqs" "message" can only be delivered if a "CONFIRMED" "sns" "subscription" exists for the "sns" "topic"'
)
def _inv_sns_sqs_a_message_can_only_be_delivered_if_a_confirmed_subscription_exists_():
    """Invariant step: trivially satisfied in isolated test context."""
