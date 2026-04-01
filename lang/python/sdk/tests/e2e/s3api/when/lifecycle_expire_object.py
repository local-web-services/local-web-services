"""When: a lifecycle "s3" rule expires a "s3" "object" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a lifecycle "s3" rule expires a "s3" "object"')
def lifecycle_expire_object(world):
    pytest.skip("Cannot trigger lifecycle expiry in this abstract context")
