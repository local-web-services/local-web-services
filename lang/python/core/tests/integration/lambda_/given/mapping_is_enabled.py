"""Given: the "lambda" "event source mapping" will be "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" was "ENABLED"')
@given('the "lambda" "event source mapping" will be "ENABLED"')
def mapping_is_enabled(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
