"""Given: mapping_is_not_enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers


@given(parsers.re(r'^the mapping is not "ENABLED"$'))
def mapping_is_not_enabled():
    pytest.skip("Cannot observe ESM state in lws without real event source")
