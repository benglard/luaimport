require 'paths'

local library = {
   name = '',
   path = (function()
      local s = debug.getinfo(4).source
      if s == nil then return nil
      else return paths.concat(s:sub(2)):match('(.*/)')
      end
   end)(),
   dest = nil
}

local asserts = {
   default = 'The function %s\'s input must be of type ',

   string = function(self, str, name, msg)
      local test = str ~= nil and type(str) == 'string' and str ~= ''
      if msg == nil then
         msg = (self.default .. 'string'):format(name)
      end
      assert(test, msg)
   end,

   table = function(self, t, name, msg)
      local test = t ~= nil and type(t) == 'table'
      if msg == nil then
         msg = (self.default .. 'table'):format(name)
      end
      assert(test, msg)
   end,

   string_or_table = function(self, input, name, msg)
      if type(input) == 'string' then
         self:string(input, name, msg)
      elseif type(input) == 'table' then
         self:table(input, name, msg)
      else
         if msg == nil then
            msg = (self.default .. 'string or table'):format(name)
         end
         assert(false, msg)
      end
   end,
}

local function getlocal(stack, var)
   local idx = 1
   while true do
      local name, val = debug.getlocal(stack, idx)
      if name == nil then break else
         if var == name then
            return val
         end
      end
      idx = idx + 1
   end
   return nil
end

package = function(name)
   asserts:string(name, 'package')
   library.name = name
   library.dest = _G[name] or getlocal(3, name)
   asserts:table(library.dest, nil,
      'Before calling import, create a table ' .. 
      'to store your module and call function package')
end

import = function(src)
   asserts:string(library.name, nil, 'Before calling import, call function package')
   asserts:string_or_table(src, 'import')

   if type(src) == 'string' then src = {src} end
   for idx, item in pairs(src) do
      local path = string.format('%s%s.lua', library.path, item)
      local file = dofile(path)
      if type(file) == 'table' then
         for name, val in pairs(file) do
            library.dest[name] = val
         end
      else
         library.dest[item] = file
      end
   end
end