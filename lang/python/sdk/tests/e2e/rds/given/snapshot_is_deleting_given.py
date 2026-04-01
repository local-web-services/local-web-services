"""Given: the "rds" "snapshot" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "rds" "snapshot" was "DELETING"')
def snapshot_is_deleting_given():
    pytest.skip("Cannot observe DELETING snapshot state in lws")
