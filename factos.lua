local tests = require("tests")
local passed = 0
local failed = 0
local time = os.clock()
for index, tests_table in pairs(tests) do
  for index, test in pairs(tests_table) do
    local result, msg = pcall(test)
    print("\n")
    if result == true then
      passed = passed + 1
      print(tostring(index) .. " passed\n")
    else
      failed = failed + 1
      print(tostring(index) .. " failed")
      print(msg .. "\n")
    end
  end
end
print("=====================\n\n")
print("Results:\n")
print("Passed: " .. tostring(passed) .. " tests.")
print("Failed: " .. tostring(failed) .. " tests.\n")
print("Time taken: " .. tostring(string.format("%.2f", os.clock() - time)) .. " seconds.\n")
if failed == 0 then
  return print("============== All tests passed successfully ==============")
end
