"""When: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation')
def lambda_writes_object(world):
    pytest.skip("Cannot trigger Lambda object write in lws")
