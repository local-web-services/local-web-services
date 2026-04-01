"""When: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" "function" writes an item to the "dynamodb" "table" during invocation')
def lambda_writes_item(world):
    pytest.skip("Cannot trigger Lambda item write in lws")
