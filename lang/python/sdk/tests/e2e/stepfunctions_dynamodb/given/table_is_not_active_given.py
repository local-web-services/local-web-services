"""Given: the table is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table is not "ACTIVE"')
def table_is_not_active_given():
    pytest.skip(
        "lws does not validate DynamoDB table lifecycle state when configuring a state machine task"
    )
