"""Given: the parameter does not exist or is "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the parameter does not exist or is "DELETED"')
def param_not_exist_or_deleted(world):
    world["param_deleted"] = True
