"""Given: the "memorydb" "snapshot" was not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "snapshot" was not "AVAILABLE"')
def snapshot_is_not_available_given():
    pytest.skip("Cannot control snapshot availability state in lws")
