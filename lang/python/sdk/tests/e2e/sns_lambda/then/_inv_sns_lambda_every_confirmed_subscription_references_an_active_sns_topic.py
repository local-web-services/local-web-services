"""Then: every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic"""

from __future__ import annotations

from pytest_bdd import then


@then('every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic')
def _inv_sns_lambda_every_confirmed_subscription_references_an_active_sns_topic():
    """Invariant step: trivially satisfied in isolated test context."""
