package = 'luaimport'
version = 'scm-1'

source = {
   url = 'git://github.com/benglard/luaimport',
}

description = {
   summary = 'Easy imports/packages for Lua',
   detailed = 'Easy imports/packages for Lua',
   homepage = 'https://github.com/benglard/luaimport'
}

dependencies = {
   'lua >= 5.1',
   'paths >= 1.0'
}

build = {
   type = 'builtin',
   modules = {
      ['luaimport.init'] = 'luaimport/init.lua',
   }
}