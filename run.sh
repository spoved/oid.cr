set -e

args="--exclude-warnings /usr/local/Cellar/crystal --error-trace"
example=05

echo "Refreshing docs"
rm -rf ./docs
crystal docs ./src/oid.cr ./examples/${example}/main.cr

echo "Starting example ${example}"
crystal ./examples/${example}/main.cr ${args}
