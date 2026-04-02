"""Given: the "lambda" "event source mapping" was "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" was "ENABLED"')
def esm_is_enabled():
    pytest.skip("Cannot pre-create event source mapping in lws")
