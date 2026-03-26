"""Then: compaction is enabled for the table"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("compaction is enabled for the table")
def compaction_is_enabled_then():
    pytest.skip("Cannot observe internal table compaction state in lws")
