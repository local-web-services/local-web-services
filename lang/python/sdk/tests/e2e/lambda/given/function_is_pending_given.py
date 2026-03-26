"""Given: function_is_pending_given"""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers


@given(parsers.re(r'^the function is "PENDING"$'))
def function_is_pending_given():
    pytest.skip("Cannot observe Lambda PENDING state in lws without lifecycle dwell")
