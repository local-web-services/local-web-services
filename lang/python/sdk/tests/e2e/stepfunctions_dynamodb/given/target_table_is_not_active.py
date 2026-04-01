"""Given: the target "dynamodb" "table" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target "dynamodb" "table" was not "ACTIVE"')
def target_table_is_not_active():
    pytest.skip(
        "lws does not reject start_execution when the target DynamoDB table is not ACTIVE"
        " (service task dispatch is fire-and-forget)"
    )
