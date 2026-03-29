"""Given: compaction is enabled for the table"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("compaction is enabled for the table")
def compaction_enabled_given():
    pytest.skip("Cannot configure table compaction in this context")
