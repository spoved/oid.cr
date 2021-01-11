# OID

A graphics library that is designed from the ground up to use Entity based architecture ([entitas.cr](https://github.com/spoved/entitas.cr)). Still a work in progress.

## Installation

1. Add the dependency to your `shard.yml`:

  ```yaml
  dependencies:
    oid:
      github: spoved/oid.cr
  ```

2. Run `shards install`

## Usage

To generate an app shell, use the `oid-cli` to generate the base system and controllers.

From the root of your project:

```shell
cd ./lib/oid
./bin/oid-cli gen <project_name> ../../src
```

Then simply require the generated `main.cr` into your entrypoint. Check the `TODO`s in each of the generated files for
places to add your code and examples.

## Development

Required tools/libs:

* llvm >= 8
* cmake >= 3.14
* raylib ~> 3.4.0

### Mac OSX

```shell
brew install llvm cmake raylib
```

Build raylib bindings:

```shell
git submodule update --init --recursive
export CLANG_BINARY=/usr/local/opt/llvm/bin/clang++
cmake .
make bindings
```

or run `./build.sh`

### Linux

Will add instructions in the future

### Windows

Not supported at this time

## Contributing

1. Fork it (<https://github.com/spoved/oid/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Credit

Vector logic/code:

https://github.com/ajselvig/crystal_vector_math
https://github.com/garnet-engine/math
https://github.com/unn4m3d/crystaledge

## Contributors

- [Holden Omans](https://github.com/kalinon) - creator and maintainer
