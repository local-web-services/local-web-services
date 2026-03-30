"""Given: the parameter is "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the parameter is "DELETED"')
def param_is_deleted_given(world):
    world["param_deleted"] = True
