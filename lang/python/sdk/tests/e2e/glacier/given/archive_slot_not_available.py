"""Given: the archive slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the archive slot is not available")
def archive_slot_not_available():
    pytest.skip("Cannot exhaust archive slot limit in lws")
