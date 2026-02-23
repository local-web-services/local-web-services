"""Bazel py_test entry point: discovers and runs tests with pytest."""
import os
import sys
import pytest

if __name__ == "__main__":
    test_dir = os.path.join(os.path.dirname(__file__), "tests")
    sys.exit(pytest.main([test_dir, "-v", "--tb=short"] + sys.argv[1:]))
