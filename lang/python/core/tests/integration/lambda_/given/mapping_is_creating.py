"""Given: the "lambda" "event source mapping" was "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" was "CREATING"')
def mapping_is_creating(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
