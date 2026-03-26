"""Given: the function does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the function does not exist")
def events_lambda_function_does_not_exist():
    pytest.skip("lws does not validate Lambda target existence in put_targets")
