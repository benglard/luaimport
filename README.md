# luaimport - Easy imports/packages for Lua

luaimport presents (what I think is) an interesting method for handling the creation of packages/modules in Lua.

To use luaimport, follow these steps:
* ```require 'luaimport'```
* Create a table (local or global both work) to store your package, e.g. ```lib = {}```
* Call ```package``` with a single string argument, the name of the package table, e.g. ```package 'lib'```
* Call ```import``` with a single string argument, the name of the file, e.g. ```import 'libfilename'```
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
testlib = {}
package 'testlib'
import 'testfile'
return testlib
```

You can also import many files at once by passing in a single table argument to ```import```, like so:

```lua
require 'luaimport'
local lib = {}
package 'lib'
import {
 'libfile1',
 'libfile2',
 'libfile3'
}
return lib
```