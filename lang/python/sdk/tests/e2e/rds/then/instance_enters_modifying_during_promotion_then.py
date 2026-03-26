"""Then: the instance enters "MODIFYING" state during promotion"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the instance enters "MODIFYING" state during promotion')
def instance_enters_modifying_during_promotion_then():
    pytest.skip("Cannot observe internal instance modification during promotion in lws")
