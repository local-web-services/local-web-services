"""Given: the target table is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target table is "DELETING"')
def apigw_dynamodb_target_table_is_deleting():
    pytest.skip("Cannot simulate DELETING table state in lws")
