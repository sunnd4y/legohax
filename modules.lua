-- // Idk if Module Help your code faster and better but its cool
-- // Example of a module for outputting messages


    local Modules = {}

do -- // Compresss code / Put them inside scope so the variable aint go no where (might help reduce garbage collection or reduce cache)
    do -- // also leave the comments on each scope so you can comeback and fix it easier
        function Modules.Output(type: number | string, text: string)
        local OutputType
        if type == 1 or type:lower() == "print" then
            OutputType = print
        elseif type == 2 or type:lower() == "warn" then
            OutputType = warn
          elseif type == 3 or type:lower() == "error" then
            OutputType = error
           else
            OutputType = print -- // Default to print if the type is invalid
          end
          return OutputType("[Sunnd4y Output] : " .. text)
       end
    end; -- use ; as mark that its the end of scope so it will easier to read

    do -- // Main
       -- // Example usage

        Modules.Output(1, "Hello, This is print")
    end;
end 



