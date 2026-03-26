"""Then: the domain is "AVAILABLE" again"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the domain is "AVAILABLE" again')
def domain_is_available_again_then(world):
    pytest.skip("Cannot observe domain update completion in lws")
