"""Given: the "ssm" "parameter" tag association was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "ssm" "parameter" tag association was not "ACTIVE"')
def tag_association_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
