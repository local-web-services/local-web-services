"""Given: the domain is not "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is not "DELETING"')
def es_domain_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
