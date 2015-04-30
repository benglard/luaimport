require 'paths'

Package = function(files)
   if type(files) == 'string' then files = {files} end

   local source = debug.getinfo(2).source
   if source == nil then return nil
   else source = paths.concat(source:sub(2)):match('(.*/)')
   end

   local rv = {}
   for idx, item in pairs(files) do
      local path = string.format('%s%s.lua', source, item)
      local file = dofile(path)
      if type(file) == 'table' then
         for name, val in pairs(file) do
            rv[name] = val
         end
      else
         rv[item] = file
      end
   end

   return rv
end