"""Given: mapping_is_not_disabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers


@given(parsers.re(r'^the mapping is not "DISABLED"$'))
def mapping_is_not_disabled():
    pytest.skip("Cannot observe ESM state in lws without real event source")
