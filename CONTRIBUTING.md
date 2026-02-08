# Contributing to LDK

Thanks for your interest in contributing to LDK. This guide explains how to get involved.

## Reporting Bugs

Please open a [GitHub issue](https://github.com/local-development-kit/ldk/issues) and include:

- **Steps to reproduce** -- the minimal commands or configuration needed to trigger the bug
- **Expected behaviour** -- what you expected to happen
- **Actual behaviour** -- what actually happened, including any error messages or logs

## Feature Requests

If you have an idea for a new feature, the preferred approach is to raise it as an [OpenSpec](https://github.com/Fission-AI/OpenSpec/) change proposal and submit it as a pull request. An OpenSpec proposal includes a description of the change, the requirements, and scenarios that define the expected behaviour. This keeps changes well-documented and reviewable before implementation begins.

If you'd rather get feedback before writing a proposal, open a [GitHub issue](https://github.com/local-development-kit/ldk/issues) describing the feature. This helps reduce duplicated effort and gives you advice on how best to get the change added.

## Development Setup

1. Clone the repository:

```bash
git clone https://github.com/local-development-kit/ldk.git
cd ldk
```

2. Install dependencies:

```bash
make install
```

3. Run the tests:

```bash
make test
```

4. Run all checks (lint, format, complexity, tests):

```bash
make check
```

## Submitting a Pull Request

1. Fork the repository and create a branch from `main`.
2. Make your changes and add tests where appropriate.
3. Ensure all tests pass and linting is clean.
4. Open a pull request with a clear description of what you changed and why.

## License

By contributing to LDK, you agree that your contributions will be licensed under the [MIT License](LICENSE).
