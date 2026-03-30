"""Given: the table is already "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table is already "DELETING"')
def apigw_dynamodb_table_already_deleting():
    pytest.skip("Cannot simulate DELETING table state in lws")
