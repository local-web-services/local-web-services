"""Given: a state machine deletion has been finalized"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a state machine deletion has been finalized")
def sm_deletion_finalized_given():
    pytest.skip("Cannot pre-set finalized deletion state for sequence setup")
