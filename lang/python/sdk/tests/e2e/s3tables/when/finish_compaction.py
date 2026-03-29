"""When: compaction finishes on a table"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("compaction finishes on a table")
def finish_compaction(lws_session, world):
    pytest.skip("Cannot trigger internal table compaction completion in lws")
