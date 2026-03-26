"""Given: function_is_deleting_given"""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers


@given(parsers.re(r'^the function is "DELETING"$'))
def function_is_deleting_given():
    pytest.skip("Cannot observe Lambda DELETING state in lws without lifecycle dwell")
