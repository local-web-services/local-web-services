"""Given: no confirmed subscription existed for the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no confirmed subscription existed for the "sns" "topic"')
@given("no confirmed subscription existed for the topic")
def no_confirmed_subscription_exists():
    pytest.skip(
        "SNS allows publishing to a topic with no confirmed subscriptions;"
        " this constraint is not enforced"
    )
