"""Given: the domain is "PROCESSING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is "PROCESSING"')
def es_domain_is_processing(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
