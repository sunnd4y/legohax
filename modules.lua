-- // Idk if Module Help your code faster and better but its cool
-- // Example of a module for outputting messages


    local Modules = {}

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
    


-- // Example usage

Modules.Output(1, "Hello, This is print")
