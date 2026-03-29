"""Given: the parameter "EXISTS" """

from __future__ import annotations

from pytest_bdd import given


@given('the parameter "EXISTS"')
def param_exists_given(world):
    world["param_deleted"] = False
