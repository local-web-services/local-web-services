"""Given: the prod stage is not active"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the prod stage is not active")
def prod_stage_is_not_active():
    pytest.skip("Cannot set stage to non-active state in this abstract context")
