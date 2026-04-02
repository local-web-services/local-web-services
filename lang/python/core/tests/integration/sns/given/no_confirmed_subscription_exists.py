"""Given: no "sns" "subscription" was "CONFIRMED" for the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no confirmed subscription existed for the "sns" "topic"')
@given('no "sns" "subscription" was "CONFIRMED" for the "sns" "topic"')
def no_confirmed_subscription_exists():
    pytest.skip(
        "SNS allows publishing to a topic with no confirmed subscriptions;"
        " this constraint is not enforced"
    )
