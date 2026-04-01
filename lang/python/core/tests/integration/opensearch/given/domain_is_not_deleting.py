"""Given: the "elasticsearch" "domain" was not "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "domain" was not "DELETING"')
def domain_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
