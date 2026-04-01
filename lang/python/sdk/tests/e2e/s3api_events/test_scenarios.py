"""Load all S3apiEvents informal spec scenarios."""

from __future__ import annotations

import glob
import os

from pytest_bdd import scenarios

_INFORMAL = os.path.normpath(
    os.path.join(os.path.dirname(__file__), "../../../../../specification/core/informal")
)


def _has_runnable_scenarios(filepath: str) -> bool:
    with open(filepath) as f:
        content = f.read()
    return "@minimal" in content or "@standard" in content


for _f in glob.glob(os.path.join(_INFORMAL, "s3api_events", "*.feature")):
    if "sequences" not in os.path.basename(_f) and _has_runnable_scenarios(_f):
        scenarios(_f)

_sequences_file = os.path.join(_INFORMAL, "s3api_events", "sequences.feature")
if os.path.exists(_sequences_file):
    scenarios(_sequences_file)
