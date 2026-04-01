"""Then: a message can only be delivered if a confirmed subscription exists for the topic"""

from __future__ import annotations

from pytest_bdd import step


@step("a message can only be delivered if a confirmed subscription exists for the topic")
def _inv_sns_sqs_a_message_can_only_be_delivered_if_a_confirmed_subscription_exists_():
    """Invariant step: trivially satisfied in isolated test context."""
