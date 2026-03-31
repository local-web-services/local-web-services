"""Given: the "elasticsearch" "domain" was "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "domain" was "DELETED"')
def domain_is_deleted_given():
    pytest.skip("Cannot use a deleted domain as a precondition in lws")
