"""Given: the "GSI" exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "GSI" exists')
def gsi_exists():
    pytest.skip("GSI configuration is not available in integration context")
