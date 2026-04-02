"""Given: the mapped "lambda" "function" was "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the mapped "lambda" "function" was "ACTIVE"')
def mapped_function_is_active():
    pytest.skip("Cannot set up event source mapping in lws")
