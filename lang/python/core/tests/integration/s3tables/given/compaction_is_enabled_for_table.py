"""Given: compaction is enabled for the table"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("compaction is enabled for the table")
def compaction_is_enabled_for_table():
    pytest.skip("Compaction configuration is not available in integration context")
