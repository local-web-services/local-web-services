"""Given: the local "opensearch" "domain" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the local "opensearch" "domain" was not "ACTIVE"')
def local_domain_is_not_active_given():
    pytest.skip("Cannot control local domain activity state in lws")
