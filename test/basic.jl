using Printf
using OkCustomInfos



# --- Helper function to capture stdout ---
function capture_stdout(func)
    # Create a pipe for redirecting stdout
    old_stdout = stdout
    rd, wr = redirect_stdout()

    # Run the function
    func()

    # Restore stdout and read the output
    redirect_stdout(old_stdout)
    close(wr)
    output = read(rd, String)
    close(rd)

    return output
end


# --- Your Test Set ---
@testset "infoc Tests" begin

    # Test 1: Default behavior
    @testset "Default behavior" begin
        output = capture_stdout() do
            infoc("Hello %s", "World")
        end

        # We test for the prefix, the message, and the newline
        @test output == "Info: Hello World\n"
    end

    # Test 2: Custom keywords
    @testset "Custom keywords" begin
        output = capture_stdout() do
            infoc("This is an error";
                prefix="Error: ",
                prefix_color=:red)
        end

        @test output == "Error: This is an error\n"
    end

    # Test 3: Error handling (@sprintf failure)
    @testset "Error handling" begin
        # Test that it throws an ArgumentError if format is bad
        @test_throws ArgumentError infoc("Hello %s %d") # Missing args
    end

end
