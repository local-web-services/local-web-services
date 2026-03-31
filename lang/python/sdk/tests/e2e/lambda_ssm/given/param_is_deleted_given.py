"""Given: the "ssm" "parameter" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "ssm" "parameter" was "DELETED"')
def param_is_deleted_given(world):
    world["param_deleted"] = True
