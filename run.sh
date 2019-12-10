set -e

args="--exclude-warnings /usr/local/Cellar/crystal --error-trace"
example=03

echo "Refreshing docs"
rm -rf ./docs
make docs

echo "Starting example ${example}"
crystal ./examples/${example}/main.cr ${args}
