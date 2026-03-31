"""Given: the "s3 tables" "snapshot" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "snapshot" was not "ACTIVE"')
def snapshot_is_not_active_given():
    pytest.skip("Cannot control snapshot activity state in lws")
