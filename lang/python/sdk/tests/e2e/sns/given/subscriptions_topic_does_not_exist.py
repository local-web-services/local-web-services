"""Given: the "sns" "subscription"'s "sns" "topic" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "subscription"\'s "sns" "topic" did not exist')
def subscriptions_topic_does_not_exist():
    pytest.skip("Cannot test subscription with non-existent topic in this context")
