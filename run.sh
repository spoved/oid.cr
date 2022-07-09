set -e

args="--exclude-warnings /usr/local/Cellar/crystal --exclude-warnings lib --error-trace"
example=06

echo "Refreshing docs"
rm -rf ./docs
crystal docs ./src/oid.cr ./examples/${example}/main.cr

echo "Starting example ${example}"
crystal run ${args} ./examples/${example}/main.cr
