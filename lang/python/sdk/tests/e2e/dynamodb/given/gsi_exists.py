"""Given: the "GSI" exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "GSI" exists')
def gsi_exists():
    pytest.skip("Cannot configure GSI in this abstract context")
