module BancoRegistro #(           
        parameter BIT_ADDR = 4,  
        parameter BIT_DATO = 8  
    )(
    input clk,
    input rst,
    input RegWrite,      

    input [BIT_ADDR-1:0] addrRa, //Dirección de lectura
    input [BIT_ADDR-1:0] addrRb, ///Dirección de lectura

    input [BIT_ADDR-1:0] addrW,  //Dirección de escritura
    input [BIT_DATO-1:0] datW,  // Dato a escribir

    output [BIT_DATO-1:0] datOutRa, //Dato de lectura
    output [BIT_DATO-1:0] datOutRb  //Dato de lectura

    );

    localparam NREG = 2 ** BIT_ADDR;   
    
    reg [BIT_DATO-1:0] banco_registro [0:NREG-1];
    
    initial begin
       $readmemh("path_to_txt.txt", banco_registro);
    end
    
    always @(posedge clk) begin
       if (rst == 0) begin
           $readmemh("path_to_txt.txt", banco_registro);
       end else (RegWrite) begin
           banco_registro[addrW] <= datW;
       end 
    end
    
    assign  datOutRa = banco_registro[addrRa];
    assign  datOutRb = banco_registro[addrRb];

endmodule