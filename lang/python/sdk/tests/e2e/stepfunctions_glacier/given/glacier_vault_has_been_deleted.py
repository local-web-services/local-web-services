"""Given: a Glacier vault has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a Glacier vault has been deleted")
def glacier_vault_has_been_deleted():
    pytest.skip("Cannot pre-set a deleted Glacier vault state for sequence setup")
