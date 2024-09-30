// Module to drive the 7-segment display

module hex_display (value, display_enable, hex);
    input logic [1:0] value;
    input logic display_enable;
    output logic [6:0] hex;

    always_comb begin
        if (display_enable) begin
            case (value)
                2'b01: hex = 7'b1111001; // Display 1
                2'b10: hex = 7'b0100100; // Display 2
                default: hex = 7'b1111111; // Display nothing            endcase
        end else begin
            hex = 7'b1111111; // Display off
        end
    end
endmodule