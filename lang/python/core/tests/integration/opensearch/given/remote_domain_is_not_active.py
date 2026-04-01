"""Given: the remote "opensearch" "domain" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the remote "opensearch" "domain" was not "ACTIVE"')
def remote_domain_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
