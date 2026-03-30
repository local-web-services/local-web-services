"""Given: the domain is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is "DELETING"')
def es_domain_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
