module cy6264 (inout [7:0] io,input [12:0] addr,input lce1,ce2,lwe,loe);
reg[7:0]mem[255:0][31:0];
reg [7:0]dout;
wire [7:0]din;
wire [7:0]ra;
wire [4:0]ca;
	
assign ra=addr[7:0];
assign ca=addr[12:8];	
	
assign re=(~lce1 && ce2 && lwe && ~loe);
assign we=(~lce1 && ce2 && ~lwe);
	
always @ *
	begin
		if(lce1||~ce2)
			dout=8'bz;
		if(re)
			dout=mem[ra][ca];
		if(we)
			mem[ra][ca]=din;			
	end
	
assign io=re?dout:8'bz;
assign din=we?io:8'bz;
	
endmodule	

//============= TB ===============//

module tb;

wire trd, twr;
wire [7:0] tio;
reg tce1, tce2, toe, twe;
reg [12:0] tadd;
reg [7:0] tio1;

assign twr = (~tce1 & tce2 & ~twe);
assign trd = (~tce1 & tce2 & twe & ~toe);
//assign tio = trd ? tio1 : ((twe) ? tio1 : 8'bz);

cy6264 t1 (tio,tadd,tce1,tce2,twe,toe);

initial
begin	
	tce1=0;tce2=1;twe=0;toe=1; tio1=8'd0;tadd=13'd0; #10
	tce1=0;tce2=1;twe=0;toe=1; tio1=8'd125;tadd=13'd125; #10
	tce1=0;tce2=1;twe=0;toe=1; tio1=8'd101;tadd=13'd101; #10
	tce1=0;tce2=1;twe=0;toe=1; tio1=8'd69;tadd=13'd69; #10
	tce1=0;tce2=1;twe=0;toe=1; tio1=8'd2;tadd=13'd2; #10
	tce1=0;tce2=1;twe=0;toe=1; tio1=8'd255;tadd=13'd255; #10
	tce1=0;tce2=1;twe=0;toe=1; tio1=8'd55;tadd=13'd55; #10
	tce1=0;tce2=1;twe=0;toe=1; tio1=8'd1;tadd=13'd1; #10
	tce1=0;tce2=1;twe=1;toe=0; tio1=8'd55;tadd=13'd55; #10
	tce1=0;tce2=1;twe=1;toe=0; tio1=8'd255;tadd=13'd255; #10
	tce1=0;tce2=1;twe=1;toe=0; tio1=8'd0;tadd=13'd0; #10
	tce1=0;tce2=1;twe=1;toe=0; tio1=8'd1;tadd=13'd1; #10
	tce1=0;tce2=1;twe=1;toe=0; tio1=8'd125;tadd=13'd125; #10
	tce1=0;tce2=1;twe=1;toe=0; tio1=8'd101;tadd=13'd101; #10
	tce1=0;tce2=1;twe=1;toe=0; tio1=8'd69;tadd=13'd69; #10
	tce1=1; tce2=0; twe=0; toe=0; #10
	tce1=1; tce2=0; twe=0; toe=1; #10
	tce1=1; tce2=0; twe=1; toe=0; #10
	tce1=1; tce2=0; twe=1; toe=1; #10
	tce1=1; tce2=1; twe=0; toe=0; #10
	tce1=1; tce2=1; twe=0; toe=1; #10
	tce1=1; tce2=1; twe=1; toe=0; #10
	tce1=1; tce2=1; twe=1; toe=1; #10	
	tce1=0; tce2=0; twe=0; toe=0; #10
	tce1=0; tce2=0; twe=0; toe=1; #10
	tce1=0; tce2=0; twe=1; toe=0; #10
	tce1=0; tce2=0; twe=1; toe=1; #10
	tce1=1; tce2=0; twe=0; toe=0; #10
	tce1=1; tce2=0; twe=0; toe=1; #10
	tce1=1; tce2=0; twe=1; toe=0; #10
	tce1=1; tce2=0; twe=1; toe=1; #10	
	tce1=0; tce2=1; twe=1; toe=1; #10;
	end
endmodule



