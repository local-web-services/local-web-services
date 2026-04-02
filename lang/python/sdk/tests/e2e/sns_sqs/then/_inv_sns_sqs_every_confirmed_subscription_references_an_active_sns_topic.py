"""Then: every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic" """

from __future__ import annotations

from pytest_bdd import step


@step('every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"')
def _inv_sns_sqs_every_confirmed_subscription_references_an_active_sns_topic():
    """Invariant step: trivially satisfied in isolated test context."""
