local assign = import("../assign")
local typeKey = import("../typeKey")

local NumberRange = {}

setmetatable(NumberRange, {
	__tostring = function()
		return "NumberRange"
	end,
})

local prototype = {}

local metatable = {}
metatable[typeKey] = "NumberRange"

function metatable:__index(key)
	local internal = getmetatable(self).internal

	if internal[key] ~= nil then
		return internal[key]
	end

	if prototype[key] ~= nil then
		return prototype[key]
	end

	error(string.format("%s is not a valid member of NumberRange", tostring(key)), 2)
end

function metatable:__eq(other)
	return self.Min == other.Min and self.Max == other.Max
end

function NumberRange.new(...)
	if select("#", ...) == 0 then
		error("NumberRange.new must have at least one argument", 2)
	elseif select("#", ...) == 1 then
		local value = ...
		return NumberRange.new(value, value)
	end

	local min, max = ...
	if type(min) ~= "number" or type(max) ~= "number" then
		error("NumberRange.new takes in 2 numbers", 2)
	end

	local internalInstance = {
		Min = min,
		Max = max,
	}

	local instance = newproxy(true)

	assign(getmetatable(instance), metatable)
	getmetatable(instance).internal = internalInstance

	return instance
end

return NumberRange
