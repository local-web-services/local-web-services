"""When: a "neptune" "instance" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "neptune" "instance" modification completes')
def instance_modification_completes(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune instance modification completion in lws")
