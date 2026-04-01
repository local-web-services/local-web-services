"""Given: a "step functions" "state machine" deletion is finalized"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "step functions" "state machine" deletion is finalized')
def sm_deletion_finalized_given():
    pytest.skip("Cannot pre-set finalized deletion state for sequence setup")
