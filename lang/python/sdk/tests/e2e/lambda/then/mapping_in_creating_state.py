"""Then: mapping_in_creating_state"""

from __future__ import annotations

import pytest
from pytest_bdd import parsers, then


@then(parsers.re(r'^the mapping is in "CREATING" state and linked to a function$'))
def mapping_in_creating_state(world):
    pytest.skip("Cannot observe ESM CREATING state in lws")
