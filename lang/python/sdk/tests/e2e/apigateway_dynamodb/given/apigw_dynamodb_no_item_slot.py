"""Given: no item slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no item slot is available")
def apigw_dynamodb_no_item_slot():
    pytest.skip("Cannot simulate exhausted item slots in lws")
