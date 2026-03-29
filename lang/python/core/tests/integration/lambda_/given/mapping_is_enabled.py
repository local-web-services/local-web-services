"""Given: the mapping is "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the mapping is "ENABLED"')
def mapping_is_enabled(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
