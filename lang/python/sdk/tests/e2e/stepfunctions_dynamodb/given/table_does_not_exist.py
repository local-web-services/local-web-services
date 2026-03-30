"""Given: the table does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the table does not exist")
def table_does_not_exist():
    pytest.skip(
        "lws does not validate DynamoDB table existence when configuring a state machine task"
    )
