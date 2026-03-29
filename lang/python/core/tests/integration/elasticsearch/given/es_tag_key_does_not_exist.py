"""Given: the tag key does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the tag key does not exist")
def es_tag_key_does_not_exist(world):
    pytest.skip("lws RemoveTags is idempotent and does not fail on missing tag keys.")
