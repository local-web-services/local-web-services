"""Given: the mapping is "DISABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the mapping is "DISABLED"')
def mapping_is_disabled(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
