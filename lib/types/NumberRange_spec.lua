local NumberRange = import("./NumberRange")

local function extractValues(v)
	return { v.Min, v.Max }
end


describe("types.NumberRange", function()
	it("should throw if given no arguments", function()
		assert.has.errors(function()
			NumberRange.new()
		end)
	end)

	it("should have a constructor with one parameter", function()
		local v = NumberRange.new(1)

		assert.not_nil(v)
		assert.are.same({1, 1}, extractValues(v))
	end)

	it("should have a constructor with two parameters", function()
		local v = NumberRange.new(1, 200)

		assert.not_nil(v)
		assert.are.same({1, 200}, extractValues(v))
	end)

	it("should throw when bad params are passed to the constructor", function()
		assert.has.errors(function()
			NumberRange.new(1, "test")
		end)

		assert.has.errors(function()
			NumberRange.new("test", 10)
		end)
	end)

	it("should equal another NumberRange with the same min and max", function()
		local rangeA = NumberRange.new(1, 200)
		local rangeB = NumberRange.new(1, 200)

		assert.equals(rangeA, rangeB)
	end)

	it("should not equal another NumberRange with different min and max", function()
		local rangeA = NumberRange.new(1, 200)

		local rangeB1 = NumberRange.new(10, 200)
		local rangeB2 = NumberRange.new(1, 300)
		local rangeB3 = NumberRange.new(5, 10)

		assert.not_equals(rangeA, rangeB1)
		assert.not_equals(rangeA, rangeB2)
		assert.not_equals(rangeA, rangeB3)
	end)
end)
