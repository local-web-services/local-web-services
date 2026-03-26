"""Given: the configured function is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the configured function is not "ACTIVE"')
def configured_function_is_not_active_given():
    pytest.skip("lws does not support non-ACTIVE Lambda function lifecycle states")
