"""Given: function_is_failed_given"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" was "FAILED"')
def function_is_failed_given():
    pytest.skip("Cannot place Lambda function in FAILED state in lws")
