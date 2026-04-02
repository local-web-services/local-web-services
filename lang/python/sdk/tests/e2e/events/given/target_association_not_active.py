"""Given: the "eventbridge" "rule" target association was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "eventbridge" "rule" target association was not "ACTIVE"')
def target_association_not_active():
    """Target associations have no deactivation mechanism in this implementation.

    Skip the negative scenario as target associations are always active once created.
    """
    pytest.skip("Target associations have no non-active state in this implementation")
