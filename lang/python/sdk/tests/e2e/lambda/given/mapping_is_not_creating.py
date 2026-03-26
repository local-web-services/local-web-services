"""Given: mapping_is_not_creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers


@given(parsers.re(r'^the mapping is not "CREATING"$'))
def mapping_is_not_creating():
    pytest.skip("Cannot observe ESM state transitions in lws")
