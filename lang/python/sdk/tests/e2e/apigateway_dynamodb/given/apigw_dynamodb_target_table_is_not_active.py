"""Given: the target table is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target table is not "ACTIVE"')
def apigw_dynamodb_target_table_is_not_active():
    pytest.skip("Cannot simulate non-ACTIVE target table in lws")
