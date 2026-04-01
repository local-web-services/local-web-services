"""Given: kid in key_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("kid in key_status")
def kid_in_key_status():
    pytest.skip("Cannot pre-populate ElastiCache entries in lws")
