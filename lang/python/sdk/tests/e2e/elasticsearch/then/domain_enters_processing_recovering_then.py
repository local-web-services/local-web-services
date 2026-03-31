"""Then: the "elasticsearch" "domain" will be in "PROCESSING" state while recovering"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticsearch" "domain" will be in "PROCESSING" state while recovering')
def domain_enters_processing_recovering_then():
    pytest.skip("Cannot observe internal domain recovery state in lws")
