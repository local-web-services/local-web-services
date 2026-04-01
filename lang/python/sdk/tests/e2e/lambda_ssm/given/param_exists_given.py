"""Given: the "ssm" "parameter" existed"""

from __future__ import annotations

from pytest_bdd import given


@given('the "ssm" "parameter" existed')
def param_exists_given(world):
    world["param_deleted"] = False
