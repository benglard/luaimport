# luaimport - Easy imports/packages for Lua

luaimport presents (what I think is) an interesting method for handling the creation of packages/modules in Lua.

To use luaimport, follow these steps:
* ```require 'luaimport'```
* Create a table (local or global both work) to store your package, e.g. ```lib = {}```
* Call ```Package``` with a single string or table argument corresponding to those file(s) that will be imported into the package
* (optional) return the package, e.g. ```return lib```

## Example Usage

```lua
-- testfile.lua
return {
   test = true,
   word = 'hi'
}
```

```lua
-- testlib.lua
require 'luaimport'
local testlib = Package 'testlib'
return testlib
```

```lua
-- init.lua
require 'luaimport'
lib = Package {
    'libfile1',
    'libfile2',
    'libfile3'
}
```