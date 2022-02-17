function mult(str, times)
	local tmp = ""
	for i=1, times do
		tmp = tmp..str
	end
	return tmp
end

function p_iter(t, iter)
	local s=""
	s=s.."table {\n"
	for k, v in pairs(t) do
		if (type(v) == "table") then
			s=s..mult("\t", iter)..tostring(k).." = "..p_iter(v, iter+1)..",\n"
		elseif (type(v) == "string") then
			s=s..mult("\t", iter)..tostring(k)..' = "'..tostring(v)..'",\n'
		else
			s=s..mult("\t", iter)..tostring(k).." = "..tostring(v)..",\n"
		end
	end
	s=s..mult("\t", iter-1).."}"
	return s
end

function p(tbl)
	print(p_iter(tbl, 1))
end

function _x(num)
	return string.format("%X", num)
end

_bin = {
	["0"] = "0000",
	["1"] = "0001",
	["2"] = "0010",
	["3"] = "0011",
	["4"] = "0100",
	["5"] = "0101",
	["6"] = "0110",
	["7"] = "0111",
	["8"] = "1000",
	["9"] = "1001",
	["A"] = "1010",
	["B"] = "1011",
	["C"] = "1100",
	["D"] = "1101",
	["E"] = "1110",
	["F"] = "1111"
}

function b(num)
	local s = ""
	local hex = _x(num)
	for i=1, #hex do
		s = s.._bin[ hex:sub(i,i) ]
	end
	return s
end

function x(num)
	return "0x".._x(num)
end

function f(str)
	local s = (string.gsub(str, "#{(.-)}", function (match)
		return tostring(load("return "..match)())
	end))

	return (string.gsub(s, "%$(%w+)", os.getenv))
end

function ansi()
	io.write("\027[0m")
	for i=30, 40 do
		io.write("\027[", i, "mColor ", i, "\n")
	end

	for i=30, 40 do
		io.write("\027[1m\027[", i, "mColor ", i, "\n")
	end
end
