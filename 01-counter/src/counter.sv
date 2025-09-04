`timescale 1ns / 1ps
/**
* updown_counter:
* A simple up/down counter with load functionality.
*
* Features:
* - 4-bit counter
* - Asynchronous reset
* - Load functionality: on load signal, the counter loads the input value
* - Up/Down counting: controlled by the up_down signal (1 for up, 0 for down)
* - Enable signal to control counting: when enabled, the counter counts; when disabled, it holds its value
*/
module updown_counter(
    input logic clk,       // Clock input
    input logic rst_n,     // Active-low reset
    input logic load,      // Load enable
    input logic up_down,   // Direction control (1 = up, 0 = down)
    input logic enable,    // Counter enable
    input logic [3:0] d_in,// Input data for loading
    output logic [3:0] count // Counter output
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset - counter goes to 0
            count <= 4'b0000;
        end
        else if (load) begin
            // Load operation has highest priority (after reset)
            count <= d_in;
        end
        else if (enable) begin
            // Counter is enabled, check direction
            if (up_down) begin
                // Count up
                count <= count + 1'b1;
            end
            else begin
                // Count down
                count <= count - 1'b1;
            end
        end
    end

endmodule