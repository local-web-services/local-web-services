"""Then: mapping_is_enabled_then"""

from __future__ import annotations

import pytest
from pytest_bdd import parsers, then


@then(parsers.re(r'^the mapping is "ENABLED"$'))
def mapping_is_enabled_then(world):
    pytest.skip("Cannot observe ESM ENABLED state in lws")
