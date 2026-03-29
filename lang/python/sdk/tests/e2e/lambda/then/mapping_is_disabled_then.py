"""Then: mapping_is_disabled_then"""

from __future__ import annotations

import pytest
from pytest_bdd import parsers, then


@then(parsers.re(r'^the mapping is "DISABLED" and inactive$'))
def mapping_is_disabled_then(world):
    pytest.skip("Cannot observe ESM DISABLED state in lws")
