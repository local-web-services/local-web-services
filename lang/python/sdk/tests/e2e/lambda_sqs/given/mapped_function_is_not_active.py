"""Given: the mapped "lambda" "function" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the mapped "lambda" "function" was not "ACTIVE"')
def mapped_function_is_not_active():
    pytest.skip("Cannot set up event source mapping in lws")
