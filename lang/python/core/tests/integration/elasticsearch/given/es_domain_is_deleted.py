"""Given: the "elasticsearch" "domain" was "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "domain" was "DELETED"')
def es_domain_is_deleted(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
