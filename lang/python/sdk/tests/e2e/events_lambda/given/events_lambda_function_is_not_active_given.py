"""Given: the function is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the function is not "ACTIVE"')
def events_lambda_function_is_not_active_given():  # noqa: ARG001
    pytest.skip("lws does not validate Lambda target state in put_targets")
