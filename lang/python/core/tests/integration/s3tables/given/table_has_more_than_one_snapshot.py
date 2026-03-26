"""Given: the table has more than one snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the table has more than one snapshot")
def table_has_more_than_one_snapshot():
    pytest.skip("Snapshot management is not available in integration context")
