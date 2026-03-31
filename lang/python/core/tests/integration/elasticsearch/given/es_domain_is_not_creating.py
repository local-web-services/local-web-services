"""Given: the "elasticsearch" "domain" was not "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "domain" was not "CREATING"')
def es_domain_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
