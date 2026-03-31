"""Given: a "lambda" "function" is invoked asynchronously"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "function" is invoked asynchronously')
def lambda_seq_invoked_async():
    pytest.skip("Cannot trigger Lambda async invocation in lws without Docker")
