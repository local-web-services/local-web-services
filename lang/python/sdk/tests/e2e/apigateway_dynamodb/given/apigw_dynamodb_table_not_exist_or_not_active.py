"""Given: the table does not exist or is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table does not exist or is not "ACTIVE"')
def apigw_dynamodb_table_not_exist_or_not_active():
    pytest.skip("Cannot simulate non-ACTIVE DynamoDB table in lws")
