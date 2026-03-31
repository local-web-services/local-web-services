"""Given: the "rds" "instance" is neither "AVAILABLE" nor "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "rds" "instance" is neither "AVAILABLE" nor "FAILED"')
def instance_is_neither_available_nor_failed(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
