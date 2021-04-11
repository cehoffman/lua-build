# lua-build

lua-build is an [luaenv](https://github.com/cehoffman/luaenv) plugin
that provides a `luaenv install` command to compile and install
different versions of Lua on UNIX-like systems. It works just like
[ruby-build](https://github.com/sstephenson/ruby-build) since it is ruby-build
but for lua.

You can also use lua-build without luaenv in environments where you
need precise control over Lua version installation.


## Installation

### Installing as an luaenv plugin (recommended)

Installing lua-build as an luaenv plugin will give you access to the
`luaenv install` command.

    git clone git://github.com/cehoffman/lua-build.git ~/.luaenv/plugins/lua-build

This will install the latest development version of lua-build into
the `~/.luaenv/plugins/lua-build` directory. From that directory, you
can check out a specific release tag. To update lua-build, run `git
pull` to download the latest changes.

### Installing as a standalone program (advanced)

Installing lua-build as a standalone program will give you access to
the `lua-build` command for precise control over Lua version
installation. If you have luaenv installed, you will also be able to
use the `luaenv install` command.

    git clone git://github.com/cehoffman/lua-build.git
    cd lua-build
    ./install.sh

This will install lua-build into `/usr/local`. If you do not have
write permission to `/usr/local`, you will need to run `sudo
./install.sh` instead. You can install to a different prefix by
setting the `PREFIX` environment variable.

To update lua-build after it has been installed, run `git pull` in
your cloned copy of the repository, then re-run the install script.

### Installing with Homebrew (for macOS users)

macOS users can install lua-build with the
[Homebrew](https://brew.sh) package manager. This
will give you access to the `lua-build` command. If you have luaenv
installed, you will also be able to use the `luaenv install` command.

*This is the recommended method of installation if you installed luaenv
 with Homebrew.*

    brew install lua-build

Or, if you would like to install the latest development release:

    brew install --HEAD lua-build


## Usage

### Using `luaenv install` with luaenv

To install a Lua version for use with luaenv, run `luaenv install` with
the exact name of the version you want to install. For example,

    luaenv install 5.2.1

Lua versions will be installed into a directory of the same name
under `~/.luaenv/versions`.

To see a list of all available Lua versions, run `luaenv install --list`.
You may also tab-complete available Lua
versions if your luaenv installation is properly configured.

### Using `lua-build` standalone

If you have installed lua-build as a standalone program, you can use
the `lua-build` command to compile and install Lua versions into
specific locations.

Run the `lua-build` command with the exact name of the version you
want to install and the full path where you want to install it. For
example,

    lua-build 5.1.5 ~/local/lua-5.1.5

To see a list of all available Lua versions, run `lua-build
--definitions`.

Pass the `-v` or `--verbose` flag to `lua-build` as the first
argument to see what's happening under the hood.

### Custom definitions

Both `luaenv install` and `lua-build` accept a path to a custom
definition file in place of a version name. Custom definitions let you
develop and install versions of Lua that are not yet supported by
lua-build.

See the [lua-build built-in
definitions](https://github.com/cehoffman/lua-build/tree/master/share/lua-build)
as a starting point for custom definition files.

### Special environment variables

You can set certain environment variables to control the build
process.

* `TMPDIR` sets the location where lua-build stores temporary files.
* `LUA_BUILD_BUILD_PATH` sets the location in which sources are
  downloaded and built. By default, this is a subdirectory of
  `TMPDIR`.
* `LUA_BUILD_CACHE_PATH`, if set, specifies a directory to use for
  caching downloaded package files.
* `LUA_BUILD_MIRROR_URL` overrides the default mirror URL root to one
  of your choosing.
* `LUA_BUILD_SKIP_MIRROR`, if set, forces lua-build to download
  packages from their original source URLs instead of using a mirror.
* `CC` sets the path to the C compiler.
* `CONFIGURE_OPTS` lets you pass additional options to `./configure`.
* `MAKE` lets you override the command to use for `make`. Useful for
  specifying GNU make (`gmake`) on some systems.
* `MAKE_OPTS` (or `MAKEOPTS`) lets you pass additional options to
  `make`.
* `LUA_CONFIGURE_OPTS` and `LUA_MAKE_OPTS` allow you to specify
  configure and make options for buildling MRI. These variables will
  be passed to Lua only, not any dependent packages (e.g. libyaml).

### Checksum verification

If you have the `md5`, `openssl`, or `md5sum` tool installed,
lua-build will automatically verify the MD5 checksum of each
downloaded package before installing it.

Checksums are optional and specified as anchors on the package URL in
each definition. (All bundled definitions include checksums.)

### Package download mirrors

lua-build will first attempt to download package files from a mirror
hosted on Amazon CloudFront. If a package is not available on the
mirror, if the mirror is down, or if the download is corrupt,
lua-build will fall back to the official URL specified in the
defintion file.

You can point lua-build to another mirror by specifying the
`LUA_BUILD_MIRROR_URL` environment variable--useful if you'd like to
run your own local mirror, for example. Package mirror URLs are
constructed by joining this variable with the MD5 checksum of the
package file.

If you don't have an MD5 program installed, lua-build will skip the
download mirror and use official URLs instead. You can force
lua-build to bypass the mirror by setting the
`LUA_BUILD_SKIP_MIRROR` environment variable.

### Package download caching

You can instruct lua-build to keep a local cache of downloaded
package files by setting the `LUA_BUILD_CACHE_PATH` environment
variable. When set, package files will be kept in this directory after
the first successful download and reused by subsequent invocations of
`lua-build` and `luaenv install`.

The `luaenv install` command defaults this path to `~/.luaenv/cache`, so
in most cases you can enable download caching simply by creating that
directory.

### Keeping the build directory after installation

Both `lua-build` and `luaenv install` accept the `-k` or `--keep`
flag, which tells lua-build to keep the downloaded source after
installation. This can be useful if you need to use `gdb` and
`memprof` with Lua.

Source code will be kept in a parallel directory tree
`~/.luaenv/sources` when using `--keep` with the `luaenv install`
command. You should specify the location of the source code with the
`LUA_BUILD_BUILD_PATH` environment variable when using `--keep` with
`lua-build`.


## Getting Help

Please see the [lua-build
wiki](https://github.com/cehoffman/lua-build/wiki) for solutions to
common problems.

If you can't find an answer on the wiki, open an issue on the [issue
tracker](https://github.com/cehoffman/lua-build/issues). Be sure to
include the full build log for build failures.


### License

(The MIT License)

Copyright (c) 2013 Sam Stephenson, Chris Hoffman

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
