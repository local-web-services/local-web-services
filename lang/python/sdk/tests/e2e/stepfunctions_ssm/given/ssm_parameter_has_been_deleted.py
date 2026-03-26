"""Given: a parameter has been deleted from "SSM" Parameter Store"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a parameter has been deleted from "SSM" Parameter Store')
def ssm_parameter_has_been_deleted():
    pytest.skip("Cannot pre-set a deleted SSM parameter state for sequence setup")
