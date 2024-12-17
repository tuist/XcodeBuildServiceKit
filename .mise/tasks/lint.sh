#!/bin/bash
# mise description="Lint the project using SwiftLint and SwiftFormat"
set -euo pipefail

swiftformat $MISE_PROJECT_ROOT --lint
swiftlint lint --quiet --config $MISE_PROJECT_ROOT/.swiftlint.yml $MISE_PROJECT_ROOT/Sources
