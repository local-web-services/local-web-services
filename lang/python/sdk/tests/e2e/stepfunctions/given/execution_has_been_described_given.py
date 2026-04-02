"""Given: a "step functions" "execution" is described"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "step functions" "execution" is described')
def execution_has_been_described_given():
    pytest.skip("Cannot pre-set a described execution state for sequence setup")
