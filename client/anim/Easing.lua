--[[
	Used to create better looking and more natural looking easing, instead of using
	preset easing functions. Probably could use this with Lagrange or another spline
	calculation function to easily calculate a nice looking curve to animate
	something.

	Originally created by Mozilla. Ported to Lua by Iplaydev.
]]

local NEWTON_ITERATIONS = 4
local NEWTON_MIN_SLOPE = 0.001
local SUBDIVISION_PRECISION = 0.0000001
local SUBDIVISION_MAX_ITERATIONS = 10

local kSplineTableSize = 11
local kSampleStepSize = 1 / (kSplineTableSize - 1)

local function A(a1, a2)
	return 1 - 3 * a2 + 3 * a1
end

local function B(a1, a2)
	return 3 * a2 - 6 * a1
end

local function C(a)
	return 3 * a
end

-- x(t) or y(t) given t, x1 (or y1), and x2 (or y2).
local function CalculateBezier(t, a1, a2)
	return ((A(a1, a2) * t + B(a1, a2)) * t + C(a1)) * t -- TODO: there has to be a simplification of this expression
end

-- dx/dt or dy/dy given t, x1 (or y1), and x2 (or y2).
local function CalculateSlope(t, a1, a2)
	return 3 * A(a1, a2) * t * t + 2 * B(a1, a2) * t + C(a1)
end

-- also called binary subdivide
local function CalculateDichotomic(x, a, b, x1, x2)
	local currX, currT, i = 0
	while (math.abs(currX) > SUBDIVISION_PRECISION and (i += 1) < SUBDIVISION_MAX_ITERATIONS) do
		-- go halfway between a and b
		currT = a + (b - a) / 2
		currX = CalculateBezier(currT, x1, x2) - x
		if currX > 0 then
			b = currT
		else
			a = currT
		end
	end
	return currT
end

local function CalculateNewton(x, gt, x1, x2)
	for i = 1, NEWTON_ITERATIONS do
		local currSlope = CalculateSlope(gt, x1, x2)
		if currSlope == 0 then
			return gt		
		end
		local currX = CalculateBezier(gt, x1, x2) - x
		gt -= currX / currSlope
	end
	return gt
end

local function CalculateLinear(x)
	return x
end

return function(x1, y1, x2, y2)
	assert(0 <= x1 and x1 <= 1 and 0 <= x2 and x2 <= 1, "bezier x values must be in [0, 1] range")

	if x1 == y1 and x2 == y2 then return CalculateLinear end

	local SampleValues = {}
	for i = 0, kSplineTableSize - 1 do
		SampleValues[i] = CalculateBezier(i * kSampleStepSize, x1, x2) 
	end

	-- calculate the t at a given x so we can calculate the final output using the y bezier.
	local function CalculateT(x)
		local IntervalStart = 0
		local CurrentSample = 1
		local LastSample = kSplineTableSize - 1

		while CurrentSample ~= LastSample and SampleValues[CurrentSample] <= x do
			IntervalStart += kSampleStepSize
			CurrentSample += 1
		end
		CurrentSample -= 1

		local Distance = (x - SampleValues[CurrentSample]) / (SampleValues[CurrentSample + 1] - SampleValues[CurrentSample])
		local gt = IntervalStart + Distance * kSampleStepSize

		local InitialSlope = CalculateSlope(gt, x1, x2)
		if InitialSlope >= NEWTON_MIN_SLOPE then
			return CalculateNewton(x, gt, x1, x2)
		elseif InitialSlope == 0 then
			return gt
		else
			return CalculateDichotomic(x, IntervalStart, IntervalStart + kSampleStepSize, x1, x2)
		end
	end

	return function(x)
		if x == 0 or x == 1 then
			return x
		end
		return CalculateBezier(CalculateT(x), y1, y2)
	end
end
