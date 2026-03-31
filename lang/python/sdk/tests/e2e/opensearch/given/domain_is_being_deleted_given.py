"""Given: the "opensearch" "domain" is being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "domain" is being deleted')
def domain_is_being_deleted_given():
    pytest.skip("Cannot observe internal domain deletion state in lws")
