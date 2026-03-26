"""Given: mapping_is_creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers


@given(parsers.re(r'^the mapping is "CREATING"$'))
def mapping_is_creating():
    pytest.skip("Cannot observe ESM CREATING state in lws")
