"""Given: the "sns" "subscription" does not belong to this "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "subscription" does not belong to this "sns" "topic"')
def subscription_not_belong_to_topic():
    pytest.skip("Cannot test cross-topic subscription isolation in integration test context")
