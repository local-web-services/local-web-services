"""Given: mapping_is_enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers


@given(parsers.re(r'^the mapping is "ENABLED"$'))
def mapping_is_enabled():
    pytest.skip("Cannot observe ESM ENABLED state in lws without real event source")
