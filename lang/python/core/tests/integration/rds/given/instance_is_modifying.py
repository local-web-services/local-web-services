"""Given: the instance is "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is "MODIFYING"')
def instance_is_modifying(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
