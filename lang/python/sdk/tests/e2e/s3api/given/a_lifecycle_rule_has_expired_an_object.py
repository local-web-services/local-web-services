"""Given: a lifecycle "s3" rule expires a "s3" "object" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a lifecycle "s3" rule expires a "s3" "object"')
def a_lifecycle_rule_has_expired_an_object():
    pytest.skip("Cannot trigger lifecycle expiry in this abstract context")
