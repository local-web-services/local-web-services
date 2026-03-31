"""Given: the "sns" "topic" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "topic" was not "ACTIVE"')
def topic_is_not_active_given():
    pytest.skip("Cannot configure lifecycle state in integration test context")
