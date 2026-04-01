"""Given: eid in esm_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("eid in esm_status")
def eid_in_esm_status():
    pytest.skip("Cannot create an event source mapping in lws")
