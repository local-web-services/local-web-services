"""Given: the "elasticsearch" "domain" was "PROCESSING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "domain" was "PROCESSING"')
def domain_is_processing_given():
    pytest.skip("Cannot trigger internal domain PROCESSING state in lws")
