"""Given: the "elasticsearch" "domain" is being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "domain" is being deleted')
def es_domain_is_being_deleted(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
