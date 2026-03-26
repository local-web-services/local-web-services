"""Given: the domain is not "PROCESSING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is not "PROCESSING"')
def es_domain_is_not_processing(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
