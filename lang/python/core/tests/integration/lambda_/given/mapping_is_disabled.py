"""Given: the "lambda" "event source mapping" was "DISABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" was "DISABLED"')
def mapping_is_disabled(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
