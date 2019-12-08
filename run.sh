set -e

args="--exclude-warnings /usr/local/Cellar/crystal --error-trace"
example=02

echo "Refreshing docs"
rm -rf ./docs
crystal doc ./examples/${example}/main.cr

echo "Starting example ${example}"
crystal ./examples/${example}/main.cr ${args}
