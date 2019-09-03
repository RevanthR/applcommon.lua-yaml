local function extract_path(require_path)
  return require_path:match("@(.*[/\\])") or './'
end

local previous_path = package.path

local previous_cache = {}
for k, v in pairs(package.loaded) do
  previous_cache[k] = v
  package.loaded[k] = nil
end

local my_path = extract_path(debug.getinfo(1).source)
package.path = my_path .. '/?.lua;' .. package.path

local yaml = require 'yaml'

for k in pairs(package.loaded) do
  package.loaded[k] = nil
end

for k, v in pairs(previous_cache) do
  package.loaded[k] = v
end

package.path = previous_path

return yaml
