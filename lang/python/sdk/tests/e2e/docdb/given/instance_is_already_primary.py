"""Given: the "documentdb" "instance" was already the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was already the primary')
def instance_is_already_primary():
    pytest.skip("Cannot control primary instance assignment in lws")
