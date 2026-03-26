"""Given: the mapping is not "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the mapping is not "ENABLED"')
def mapping_is_not_enabled(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
