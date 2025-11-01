module OkCustomInfos

using Printf

"""
    infoc(msg...; prefix="Info: ", prefix_color=:cyan)

Prints a formatted message to the console with a customizable colored prefix.

# Example

```julia
name = "World"

# Default use (cyan "Info: ")
infoc("This is the default for %s.", name)

# Your custom "Notice" example
infoc("This is a blue notice!"; prefix="Notice: ", prefix_color=:blue)

# A red "Error"
infoc("This is a red error."; prefix="Error: ", prefix_color=:red)
```

"""
function infoc(msg...; prefix="Info: ", prefix_color=:cyan)
    # 1. Print the colored prefix
    printstyled(prefix; color=prefix_color, bold=true)

    # 2. Format the main message using the passed arguments
    # - @sprintf is a macro that requires a literal format string at compile time
    # - Printf.format is a function that can work with runtime format strings by first creating a Printf.Format object
    s = Printf.format(Printf.Format(msg[1]), msg[2:end]...)

    # 3. Print the message
    println(s)
end

export infoc


end
